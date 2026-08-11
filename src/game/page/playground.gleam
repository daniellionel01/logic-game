import game/level/color
import game/program

pub fn sample_stack() {
  [
    program.always(program.Forward),
    program.always(program.RotateRight),
    program.always(program.RotateLeft),
    program.always(program.Call(1)),
    program.always(program.Fill(color.Red)),
    program.when_on(color.Red, program.Forward),
    program.when_on(color.Red, program.RotateRight),
    program.when_on(color.Red, program.RotateLeft),
    program.when_on(color.Red, program.Call(1)),
    program.when_on(color.Red, program.Fill(color.Red)),
  ]
}
