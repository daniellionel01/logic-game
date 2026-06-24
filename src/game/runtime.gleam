//// The `Runtime` represents the current execution state of a `Program` running on
//// a `Level`. It tracks changing state such as the instruction stack, the
//// player's current state, and the remaining stars.
////
//// A `Program` is the set of instructions assigned to each function by the user.
////

import game/level
import game/program
import gleam/list
import gleam/string

/// This is the limit for how many instructions
/// can be contained in the stack. Everything above
/// this will be considered an overflow cause an error.
///
pub const max_stack_size = 1000

pub opaque type Runtime {
  Runtime(
    // We keep a reference back to the initial level,
    // so we can reset the state.
    level: level.Level,
    cells: List(level.Cell),
    player: level.Player,
    program: program.Program,
    remaining_stars: List(level.Star),
    stack: List(program.Instruction),
    stack_overflow: Bool,
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
    stack_overflow: False,
  )
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
