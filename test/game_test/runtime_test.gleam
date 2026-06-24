import birdie
import game/level
import game/level/color
import game/level/seed
import game/program
import game/runtime

pub fn runtime_to_string_level_1_init_test() {
  let assert Ok(level) = level.parse(seed.level_1)
  let runtime = runtime.init(level)
  runtime
  |> runtime.to_string
  |> birdie.snap(title: "runtime to string with level 1 initializes correctly")
}

pub fn runtime_to_string_level_2_solution_test() {
  let assert Ok(level) = level.parse(seed.level_2)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      program.slot(program.always(program.Forward)),
      program.slot(program.always(program.RotateLeft)),
      program.slot(program.always(program.Forward)),
      program.slot(program.always(program.RotateRight)),
      program.slot(program.always(program.Call(0))),
    ])

  runtime
  |> runtime.to_string
  |> birdie.snap(
    title: "runtime to string with level 2 and solution program correctly",
  )
}

pub fn runtime_to_string_level_3_solution_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let runtime =
    runtime.init(level)
    |> runtime.fill_program_slots(0, [
      program.slot(program.always(program.Forward)),
      program.slot(program.when_on(color.Red, program.RotateRight)),
      program.slot(program.when_on(color.Red, program.Forward)),
      program.slot(program.always(program.RotateLeft)),
      program.slot(program.always(program.Call(0))),
    ])

  runtime
  |> runtime.to_string
  |> birdie.snap(
    title: "runtime to string with level 3 and solution program correctly",
  )
}
