import game/level/color
import game/level/direction.{type Direction}
import game/position.{type Position, Position}
import gleam/dynamic
import gleam/dynamic/decode
import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string

pub type Cell {
  Cell(position: Position, color: color.Color)
}

pub type Player {
  Player(position: Position, direction: Direction)
}

pub type Star {
  Star(position: Position)
}

pub type Level {
  Level(
    player_start: Player,
    cells: List(Cell),
    stars: List(Star),
    functions: List(Int),
  )
}

pub type Size {
  Size(rows: Int, columns: Int)
}

pub fn empty() {
  Level(
    player_start: Player(Position(-1, -1), direction.North),
    cells: [],
    stars: [],
    functions: [],
  )
}

pub fn size(cells: List(Cell)) -> Size {
  let assert Ok(cell_largest_row) =
    cells
    |> list.sort(
      by: order.reverse(fn(a: Cell, b: Cell) {
        int.compare(a.position.row, b.position.row)
      }),
    )
    |> list.first
  let assert Ok(cell_largest_col) =
    cells
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
  UnknownCharacter(String)
  UnknownParsingError(String)
}

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
/// P=g
/// f0=4
/// f1=2
/// .......
/// ...R...
/// ...r...
/// .Rr^rR.
/// ...r...
/// ...R...
/// .......
/// ```
///
pub fn parse(grid: String) -> Result(Level, String) {
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

  let level = Level(..empty(), functions:)

  let level =
    list.fold(over: lines, from: level, with: fn(level_acc, current_line) {
      list.fold(over: current_line, from: level_acc, with: fn(inner_acc, cur) {
        let #(position, string) = cur
        case string {
          ">" | "v" | "<" | "^" -> {
            let direction =
              decode.run(dynamic.string(string), direction.decoder())
            let player_cell_color =
              decode.run(dynamic.string(player_cell_color), color.decoder())

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
            let color = decode.run(dynamic.string(string), color.decoder())
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
            let color = decode.run(dynamic.string(string), color.decoder())
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
  let functions = list.reverse(functions)
  let stars =
    list.sort(stars, fn(a, b) { position.compare(a.position, b.position) })
  let cells =
    list.sort(cells, fn(a, b) { position.compare(a.position, b.position) })
  let level = Level(player_start:, cells:, stars:, functions:)

  Ok(level)
}

pub fn is_level_char(char: String) -> Bool {
  case char {
    "r" | "g" | "b" | "R" | "G" | "B" | "<" | ">" | "v" | "^" -> True
    _ -> False
  }
}

pub fn do_parse_functions(
  grid: String,
  functions: List(Int),
) -> #(List(Int), String) {
  case string.split_once(grid, on: "\n") {
    Ok(#(line, rest)) -> {
      let line = string.trim(line)
      case line {
        "f=" <> size -> {
          let assert Ok(size) = int.parse(size)
          do_parse_functions(rest, [size, ..functions])
        }
        _ -> #(functions, grid)
      }
    }
    Error(_) -> #(functions, grid)
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
  |> do_trim_empty_border_left
  |> do_trim_empty_border_right
}

fn do_trim_empty_border_left(lines: List(List(String))) -> List(List(String)) {
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
      do_trim_empty_border_left(lines)
    }
  }
}

fn do_trim_empty_border_right(lines: List(List(String))) -> List(List(String)) {
  lines
  |> list.map(list.reverse)
  |> do_trim_empty_border_left
  |> list.map(list.reverse)
}

pub fn cells_to_string(
  cells: List(Cell),
  stars: List(Star),
  player: Player,
) -> String {
  let Size(rows:, columns:) = size(cells)
  list.repeat(".", times: rows * columns)
  |> list.index_map(fn(_, index) {
    let current_position = position.from_index(index, columns)

    let cell =
      list.find(cells, fn(cell) {
        position.equal(cell.position, current_position)
      })
    case cell {
      Ok(cell) -> {
        let is_player = position.equal(cell.position, player.position)

        case is_player {
          True -> {
            direction.to_string(player.direction)
          }
          False -> {
            let is_star =
              stars
              |> list.find(fn(star) {
                position.equal(star.position, cell.position)
              })
              |> result.is_ok

            let color = color.to_string(cell.color)
            case is_star {
              True -> string.uppercase(color)
              // This is not required, but makes the logic more explicit
              False -> string.lowercase(color)
            }
          }
        }
      }
      Error(_) -> "."
    }
  })
  |> list.sized_chunk(into: columns)
  |> list.map(string.join(_, with: ""))
  |> string.join(with: "\n")
}

pub fn to_string(level: Level) -> String {
  let assert Ok(cell) =
    list.find(level.cells, fn(cell) {
      position.equal(cell.position, level.player_start.position)
    })

  let player_cell_color = color.to_string(cell.color)

  let functions =
    level.functions
    |> list.map(fn(instructions) { "f=" <> int.to_string(instructions) })
    |> string.join(with: "\n")

  let cells = cells_to_string(level.cells, level.stars, level.player_start)

  "P=" <> player_cell_color <> "\n" <> functions <> "\n" <> cells
}
