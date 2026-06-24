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

import game/level

/// This is the limit for how many instructions
/// can be contained in the stack. Everything above
/// this will be considered an overflow cause an error.
///
pub const max_stack_size = 1000

pub type Program {
  Program(functions: List(List(level.Slot)))
}

pub type Runtime {
  Runtime(
    // We keep a reference back to the initial level,
    // so we can reset the state.
    level: level.Level,
    cells: List(level.Cell),
    player: level.Player,
    program: Program,
    remaining_stars: List(level.Star),
    stack: List(level.Instruction),
    stack_overflow: Bool,
  )
}
