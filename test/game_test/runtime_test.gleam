import birdie
import game/level
import game/level/color
import game/level/seed
import game/program
import game/runtime

fn slot_always(action: program.Action) -> program.Slot {
  program.Filled(program.Instruction(action:, condition: program.Always))
}

fn slot_when_on(color: color.Color, action: program.Action) -> program.Slot {
  program.Filled(program.Instruction(action:, condition: program.WhenOn(color)))
}

pub fn level_1_runtime_to_string_init_test() {
  let assert Ok(level) = level.parse(seed.level_1)
  let runtime = runtime.init(level)
  runtime
  |> runtime.to_string
  |> birdie.snap(title: "runtime to string with level 1 initializes correctly")
}

pub fn level_2_runtime_to_string_with_solution_program_test() {
  let assert Ok(level) = level.parse(seed.level_2)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      slot_always(program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Forward),
      slot_always(program.RotateRight),
      slot_always(program.Call(0)),
    ])

  runtime
  |> runtime.to_string
  |> birdie.snap(
    title: "runtime to string with level 2 and solution program correctly",
  )
}

pub fn level_3_runtime_to_string_with_solution_program_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      slot_always(program.Forward),
      slot_when_on(color.Red, program.RotateRight),
      slot_when_on(color.Red, program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Call(0)),
    ])

  runtime
  |> runtime.to_string
  |> birdie.snap(
    title: "runtime to string with level 3 and solution program correctly",
  )
}

pub fn level_3_runtime_to_string_one_stack_pass_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      slot_always(program.Forward),
      slot_when_on(color.Red, program.RotateRight),
      slot_when_on(color.Red, program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Call(0)),
    ])
    |> runtime.advance_multiple_times(6)

  runtime
  |> runtime.to_string
  |> birdie.snap(
    title: "runtime with solution for level 3 executes all 5 instructions",
  )
}

pub fn level_3_won_state_to_string_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      slot_always(program.Forward),
      slot_when_on(color.Red, program.RotateRight),
      slot_when_on(color.Red, program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Call(0)),
    ])
    |> runtime.advance_multiple_times(54)

  runtime
  |> runtime.to_string
  |> birdie.snap(title: "runtime with solution for level 3 wins")
}

pub fn level_3_still_running_state_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      slot_always(program.Forward),
      slot_when_on(color.Red, program.RotateRight),
      slot_when_on(color.Red, program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Call(0)),
    ])
    |> runtime.advance_multiple_times(50)

  assert !runtime.is_lost(runtime)
  assert !runtime.is_won(runtime)
}

pub fn level_3_won_state_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      slot_always(program.Forward),
      slot_when_on(color.Red, program.RotateRight),
      slot_when_on(color.Red, program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Call(0)),
    ])
    |> runtime.advance_multiple_times(54)

  assert !runtime.is_lost(runtime)
  assert runtime.is_won(runtime)
}

pub fn level_3_lost_state_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      // We modified the program instructions so the player
      // will eventually run out of bounds.
      slot_always(program.Forward),
      slot_always(program.RotateRight),
      slot_always(program.Forward),
      slot_always(program.RotateLeft),
      slot_always(program.Call(0)),
    ])
    |> runtime.advance_multiple_times(29)

  assert runtime.is_lost(runtime)
  assert !runtime.is_won(runtime)
}
