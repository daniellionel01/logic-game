import game/level
import game/level/color
import gleam/list

pub opaque type Program {
  Program(functions: List(List(Slot)))
}

pub fn init(level: level.Level) -> Program {
  let functions =
    list.map(level.functions, fn(size) { list.repeat(EmptySlot, times: size) })
  Program(functions)
}

pub type FunctionId {
  FunctionId(Int)
}

pub type Condition {
  Always
  WhenOn(color.Color)
}

pub type Action {
  Forward
  RotateRight
  RotateLeft
  Call(FunctionId)
  Fill(color.Color)
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

pub fn instruction_to_string(instruction: Instruction) -> String {
  todo
}
