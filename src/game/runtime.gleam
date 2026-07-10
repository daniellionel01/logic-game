//// The `Runtime` represents the current execution state of a `Program` running on
//// a `Level`. It tracks changing state such as the instruction stack, the
//// player's current state, and the remaining stars.
////
//// A `Program` is the set of instructions assigned to each function by the user.
////

import game/level
import game/level/direction
import game/position
import game/program
import gleam/dict
import gleam/list
import gleam/result
import gleam/string

/// This is the limit for how many instructions
/// can be contained in the stack. Everything above
/// this will be considered an overflow cause an error.
///
pub const max_stack_size = 1000

pub type Runtime {
  Runtime(
    // We keep a reference back to the initial level,
    // so we can reset the state.
    level: level.Level,
    cells: List(level.Cell),
    player: level.Player,
    program: program.Program,
    remaining_stars: List(level.Star),
    stack: List(program.Instruction),
  )
}

pub fn init(level: level.Level) -> Runtime {
  Runtime(
    level:,
    cells: level.cells,
    player: level.player_start,
    program: program.init(level),
    remaining_stars: level.stars,
    stack: [],
  )
}

pub fn reset(runtime: Runtime) -> Runtime {
  init(runtime.level)
}

pub fn fill_program_slots(
  runtime: Runtime,
  function: Int,
  slots: List(program.Slot),
) -> Runtime {
  let program = program.fill_slots(runtime.program, function, slots)
  Runtime(..runtime, program:)
}

pub fn to_string(runtime: Runtime) -> String {
  let program = program.to_string(runtime.program)

  let stack =
    runtime.stack
    |> list.map(program.instruction_to_string)
    |> string.join(with: ", ")
  let stack = "STACK: [" <> stack <> "]"

  let cells =
    level.cells_to_string(
      runtime.cells,
      runtime.remaining_stars,
      runtime.player,
    )

  program <> "\n\n" <> stack <> "\n\n" <> cells
}

/// A level is lost, if the stack is overflown or the
/// player is out of bounds or not on a colored cell.
///
pub fn is_lost(runtime: Runtime) -> Bool {
  let overflown = list.length(runtime.stack) >= max_stack_size
  case overflown {
    True -> True
    False -> {
      // If we do not find a cell for the player position, they
      // are out of bounds, which means that the level is lost.
      runtime.cells
      |> list.find(fn(cell) {
        position.equal(cell.position, runtime.player.position)
      })
      |> result.is_error
    }
  }
}

/// A level is won, if there are no remaining stars
/// and none of the lost conditions are met.
///
pub fn is_won(runtime: Runtime) -> Bool {
  !is_lost(runtime) && list.is_empty(runtime.remaining_stars)
}

pub fn advance_multiple_times(runtime: Runtime, times: Int) -> Runtime {
  case times {
    0 -> runtime
    n if n > 0 -> {
      let runtime = advance(runtime)
      advance_multiple_times(runtime, n - 1)
    }
    // If n is negative, we just return to avoid an infinite loop.
    _ -> runtime
  }
}

/// Advances the runtime by executing the next instruction in the stack.
///
pub fn advance(runtime: Runtime) -> Runtime {
  case runtime.stack {
    [] -> {
      // If the stack is empty, we push the instructions
      // of the first function.
      //
      case dict.get(runtime.program.functions, 0) {
        Error(_) -> runtime
        Ok(slots) -> {
          let instructions = program.slots_to_instructions(slots)
          let stack = list.append(instructions, runtime.stack)
          Runtime(..runtime, stack:)
        }
      }
    }
    [instruction, ..rest] -> {
      // We remove the instruction from the stack so that
      // the `Call` action does not accidentally keep the
      // instruction, but can consider it already
      // discarded.
      //
      let runtime = Runtime(..runtime, stack: rest)

      case instruction {
        program.Instruction(action:, condition: program.Always) -> {
          execute_action(runtime, action)
        }
        program.Instruction(action:, condition: program.WhenOn(cond_color)) -> {
          let player_cell =
            list.find(runtime.cells, fn(cell) {
              position.equal(cell.position, runtime.player.position)
            })
          case player_cell {
            Ok(level.Cell(position: _, color: cell_color))
              if cond_color == cell_color
            -> {
              execute_action(runtime, action)
            }
            _ -> runtime
          }
        }
      }
    }
  }
}

fn execute_action(runtime: Runtime, action: program.Action) -> Runtime {
  let runtime = case action {
    program.Forward -> {
      let position = runtime.player.position
      let position = case runtime.player.direction {
        direction.North -> {
          position.Position(..position, row: position.row - 1)
        }
        direction.East -> {
          position.Position(..position, column: position.column + 1)
        }
        direction.South -> {
          position.Position(..position, row: position.row + 1)
        }
        direction.West -> {
          position.Position(..position, column: position.column - 1)
        }
      }
      let player = level.Player(..runtime.player, position:)
      Runtime(..runtime, player:)
    }
    program.RotateRight -> {
      let direction = direction.rotate_right(runtime.player.direction)
      let player = level.Player(..runtime.player, direction:)
      Runtime(..runtime, player:)
    }
    program.RotateLeft -> {
      let direction = direction.rotate_left(runtime.player.direction)
      let player = level.Player(..runtime.player, direction:)
      Runtime(..runtime, player:)
    }
    program.Call(function_index) -> {
      case dict.get(runtime.program.functions, function_index) {
        Error(_) -> runtime
        Ok(slots) -> {
          let instructions = program.slots_to_instructions(slots)
          let stack = list.append(instructions, runtime.stack)
          Runtime(..runtime, stack:)
        }
      }
    }
    program.Fill(color) -> {
      let cells =
        list.map(runtime.cells, fn(cell) {
          case position.equal(cell.position, runtime.player.position) {
            False -> cell
            True -> level.Cell(..cell, color:)
          }
        })
      Runtime(..runtime, cells:)
    }
  }

  let remaining_stars =
    list.filter(runtime.remaining_stars, fn(star) {
      !position.equal(star.position, runtime.player.position)
    })

  Runtime(..runtime, remaining_stars:)
}
