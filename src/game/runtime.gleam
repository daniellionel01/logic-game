//// This module contains game logic that is independent of the UI.
////
//// This includes level definitions, user programs, and instruction execution
//// against the current state of the game.
////
//// A `Level` defines the cells, the player's starting state, the stars, and the
//// functions available to the player.
////
//// A `Program` is the set of instructions assigned to each function by the user.
////
//// A `Runtime` represents the current execution state of a `Program` running on
//// a `Level`. It tracks changing state such as the instruction stack, the
//// player's current state, and the remaining stars.
////

import gleam/dynamic
import gleam/dynamic/decode
import gleam/int
import gleam/list
import gleam/order
import gleam/string

/// This is the limit for how many instructions
/// can be contained in the stack. Everything above
/// this will be considered an overflow cause an error.
///
pub const max_stack_size = 1000

// We use cardinal directions, because "Left" and "Right"
// are also associated with rotating the player.
//
pub type Direction {
  North
  East
  South
  West
}

fn direction_decoder() -> decode.Decoder(Direction) {
  use variant <- decode.then(decode.string)
  case variant {
    "north" | "^" -> decode.success(North)
    "east" | ">" -> decode.success(East)
    "south" | "v" -> decode.success(South)
    "west" | "<" -> decode.success(West)
    _ -> decode.failure(North, "Direction")
  }
}

pub type Color {
  Red
  Blue
  Green
}

fn color_decoder() -> decode.Decoder(Color) {
  use variant <- decode.then(decode.string)
  case variant {
    "red" | "r" | "R" -> decode.success(Red)
    "blue" | "b" | "B" -> decode.success(Blue)
    "green" | "g" | "G" -> decode.success(Green)
    _ -> decode.failure(Red, "Color")
  }
}

/// A position encodes the row and column of an entity (y and x position).
///
/// They are not zero based and the very top left starts at (1, 1).
///
pub type Position {
  Position(row: Int, column: Int)
}

pub type Cell {
  Cell(position: Position, color: Color)
}

pub type Player {
  Player(position: Position, direction: Direction)
}

pub type Star {
  Star(position: Position)
}

pub type FunctionId {
  FunctionId(Int)
}

pub type Condition {
  Always
  WhenOn(Color)
}

pub type Action {
  Forward
  RotateRight
  RotateLeft
  Call(FunctionId)
  Fill(Color)
}

pub type Instruction {
  Instruction(action: Action, condition: Condition)
}

pub type Slot {
  EmptySlot
  Filled(Instruction)
}

pub type FunctionSpec {
  FunctionSpec(id: FunctionId, instructions: Int)
}

pub type Level {
  Level(
    player_start: Player,
    cells: List(Cell),
    stars: List(Star),
    functions: List(FunctionSpec),
  )
}

pub type Program {
  Program(functions: List(List(Slot)))
}

pub type Runtime {
  Runtime(
    // We keep a reference back to the initial level,
    // so we can reset the state.
    level: Level,
    cells: List(Cell),
    player: Player,
    program: Program,
    remaining_stars: List(Star),
    stack: List(Instruction),
    stack_overflow: Bool,
  )
}

pub type Size {
  Size(rows: Int, columns: Int)
}

pub fn empty_level() {
  Level(
    player_start: Player(Position(-1, -1), North),
    cells: [],
    stars: [],
    functions: [],
  )
}

pub fn level_size(level: Level) -> Size {
  let assert Ok(cell_largest_row) =
    level.cells
    |> list.sort(
      by: order.reverse(fn(a: Cell, b: Cell) {
        int.compare(a.position.row, b.position.row)
      }),
    )
    |> list.first
  let assert Ok(cell_largest_col) =
    level.cells
    |> list.sort(
      by: order.reverse(fn(a: Cell, b: Cell) {
        int.compare(a.position.column, b.position.column)
      }),
    )
    |> list.first

  let columns = cell_largest_col.position.column
  let rows = cell_largest_row.position.row

  Size(rows:, columns:)
}

// TODO unused right now but will be useful to improve level parsing
pub type LevelParsingError {
  MissingPlayerColor
  MissingFunctions
  MissingPlayerCharacter
  ZeroStars
  UnknownParsingError(String)
}

// TODO make the example level in this comment more realistic.
//
/// You can define a level with all cells, player starting position,
/// stars and functions in a grid of characters.
///
/// Uncolored (empty) cells should be denoted with a simple dot ".",
/// but any unknown character will parse as empty.
///
/// The first line defines the color of the player cell,
/// since we encode the direction of the player with the
/// character inside of the grid. A red cell for the player
/// would look like this: "P=r"
///
/// Functions are denoted with an "f", followed by an index
/// and the instruction size: "f0=2"
///
/// Cells are defined the following ways:
/// - color: r = red, g = green, b = blue
/// - star: capitalize the color (R / G / B)
/// - player including starting direction: ^, >, v, <
///
/// A full level could look like this:
/// ```
/// P=r
/// f0=2
/// f1=3
/// .........
/// .>gbrgbR.
/// ..gbrgbR.
/// .........
/// ```
///
pub fn parse_level(grid: String) -> Result(Level, String) {
  let grid = string.trim(grid)

  let assert Ok(#(player_cell_color, grid)) = string.split_once(grid, on: "\n")
  let assert Ok(#(_, player_cell_color)) =
    string.split_once(player_cell_color, on: "=")

  let #(functions, grid) = do_parse_functions(grid, [])

  let lines =
    grid
    |> string.split(on: "\n")
    |> list.map(string.to_graphemes)

  // We start by trimming any empty characters at
  // the top, bottom, left and right of each line.
  //
  // That way we are able to calculate an accurate width and height
  // of the level which is vital when traversing each character
  // and creating exact positions with `row` and `column` for
  // the positions.
  //
  // So this grid:
  // .........
  // .>gbrgbR.
  // .........
  //
  // Would become:
  // >gbrgbR
  //
  let lines = trim_empty_borders(lines)

  let lines =
    list.index_map(lines, fn(line, row) {
      let row = row + 1
      list.index_map(line, fn(character, column) {
        let column = column + 1
        #(Position(row:, column:), character)
      })
    })

  let level = Level(..empty_level(), functions:)

  let level =
    list.fold(over: lines, from: level, with: fn(level_acc, current_line) {
      list.fold(over: current_line, from: level_acc, with: fn(inner_acc, cur) {
        let #(position, string) = cur
        case string {
          ">" | "v" | "<" | "^" -> {
            let direction =
              decode.run(dynamic.string(string), direction_decoder())
            let player_cell_color =
              decode.run(dynamic.string(player_cell_color), color_decoder())

            case direction, player_cell_color {
              Ok(direction), Ok(player_cell_color) -> {
                let player_start = Player(position:, direction:)
                let cell = Cell(position:, color: player_cell_color)
                let cells = [cell, ..inner_acc.cells]
                Level(..inner_acc, player_start:, cells:)
              }
              _, _ -> inner_acc
            }
          }
          "r" | "g" | "b" -> {
            let color = decode.run(dynamic.string(string), color_decoder())
            case color {
              Ok(color) -> {
                let cell = Cell(position:, color:)
                let cells = [cell, ..inner_acc.cells]
                Level(..inner_acc, cells:)
              }
              Error(_) -> inner_acc
            }
          }
          "R" | "G" | "B" -> {
            let color = decode.run(dynamic.string(string), color_decoder())
            case color {
              Ok(color) -> {
                let cell = Cell(position:, color:)
                let cells = [cell, ..inner_acc.cells]

                let star = Star(position:)
                let stars = [star, ..inner_acc.stars]

                Level(..inner_acc, stars:, cells:)
              }
              Error(_) -> inner_acc
            }
          }
          _ -> inner_acc
        }
      })
    })

  // The last step is to order every element of level (cells, stars, functions)
  // in an ascending manner to make testing easier.
  //
  let Level(player_start:, cells:, stars:, functions:) = level
  let functions =
    list.sort(functions, fn(a, b) {
      let FunctionId(id_a) = a.id
      let FunctionId(id_b) = b.id
      int.compare(id_a, id_b)
    })
  let stars =
    list.sort(stars, fn(a, b) { compare_position(a.position, b.position) })
  let cells =
    list.sort(cells, fn(a, b) { compare_position(a.position, b.position) })
  let level = Level(player_start:, cells:, stars:, functions:)

  Ok(level)
}

pub fn compare_position(a: Position, b: Position) -> order.Order {
  case int.compare(a.row, b.row) {
    order.Lt -> order.Lt
    order.Gt -> order.Gt
    order.Eq -> int.compare(a.column, b.column)
  }
}

pub fn is_level_char(char: String) -> Bool {
  case char {
    "r" | "g" | "b" | "R" | "G" | "B" | "<" | ">" | "v" | "^" -> True
    _ -> False
  }
}

pub fn do_parse_functions(
  grid: String,
  functions: List(FunctionSpec),
) -> #(List(FunctionSpec), String) {
  let assert Ok(#(line, rest)) = string.split_once(grid, on: "\n")
  let line = string.trim(line)
  case line {
    "f" <> line -> {
      let assert Ok(#(id, size)) = string.split_once(line, on: "=")
      let assert Ok(size) = int.parse(size)
      let assert Ok(id) = int.parse(id)
      let id = FunctionId(id)
      let function = FunctionSpec(id, size)

      do_parse_functions(rest, [function, ..functions])
    }
    _ -> #(functions, grid)
  }
}

/// This trims any lines (rows or columns) that only
/// contain empty characters.
///
/// So these lines:
/// .........
/// .>gbrgbR.
/// .........
///
/// Would become:
/// >gbrgbR
///
pub fn trim_empty_borders(lines: List(List(String))) -> List(List(String)) {
  lines
  // This filters the top and bottom rows that are all empty characters
  |> list.filter(fn(line) { list.any(line, is_level_char) })
  |> do_trim_left
  |> do_trim_right
}

fn do_trim_left(lines: List(List(String))) -> List(List(String)) {
  let empty_column =
    list.all(lines, fn(line) {
      case list.first(line) {
        Ok(char) -> !is_level_char(char)
        _ -> False
      }
    })
  case lines, empty_column {
    [], _ -> []
    [_, ..], False -> lines
    [_, ..], True -> {
      let lines = list.map(lines, list.drop(_, 1))
      do_trim_left(lines)
    }
  }
}

fn do_trim_right(lines: List(List(String))) -> List(List(String)) {
  lines
  |> list.map(list.reverse)
  |> do_trim_left
  |> list.map(list.reverse)
}

pub fn level_to_string(level: Level) -> Result(String, Nil) {
  todo
}
