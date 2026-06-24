import game/level
import game/level/color
import gleam/int
import gleam/list
import gleam/string

pub opaque type Program {
  Program(functions: List(List(Slot)))
}

pub fn init(level: level.Level) -> Program {
  let functions =
    list.map(level.functions, fn(size) { list.repeat(EmptySlot, times: size) })
  Program(functions)
}

pub fn fill_slots(
  program: Program,
  function: Int,
  slots: List(Slot),
) -> Program {
  let functions =
    list.index_map(program.functions, fn(current, index) {
      case index == function {
        True -> slots
        False -> current
      }
    })
  Program(functions:)
}

pub opaque type Condition {
  Always
  WhenOn(color.Color)
}

pub type Action {
  Forward
  RotateRight
  RotateLeft
  Call(Int)
  Fill(color.Color)
}

pub opaque type Instruction {
  Instruction(action: Action, condition: Condition)
}

pub fn always(action: Action) {
  Instruction(action:, condition: Always)
}

pub fn when_on(color: color.Color, action: Action) {
  Instruction(action:, condition: WhenOn(color))
}

pub opaque type Slot {
  EmptySlot
  Filled(Instruction)
}

pub fn empty_slot() {
  EmptySlot
}

pub fn slot(instruction: Instruction) {
  Filled(instruction)
}

fn action_to_string(action: Action) -> String {
  case action {
    Forward -> "F"
    RotateRight -> "RR"
    RotateLeft -> "RL"
    Call(id) -> "C(" <> int.to_string(id) <> ")"
    Fill(color) -> "F(" <> color.to_string(color) <> ")"
  }
}

pub fn instruction_to_string(instruction: Instruction) -> String {
  let postfix = case instruction.condition {
    Always -> ""
    WhenOn(color) -> {
      let color = color.to_string(color)
      "@" <> color
    }
  }

  action_to_string(instruction.action) <> postfix
}

fn slot_to_string(slot: Slot) -> String {
  case slot {
    EmptySlot -> "_"
    Filled(instruction) -> instruction_to_string(instruction)
  }
}

pub fn to_string(program: Program) -> String {
  program.functions
  |> list.index_map(fn(slots, index) {
    let slots =
      slots
      |> list.map(slot_to_string)
      |> string.join(with: ", ")

    "F" <> int.to_string(index) <> ": [" <> slots <> "]"
  })
  |> string.join(with: "\n")
}
