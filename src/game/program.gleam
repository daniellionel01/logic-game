import game/level
import game/level/color
import gleam/dict
import gleam/int
import gleam/list
import gleam/string

pub type Functions =
  dict.Dict(Int, List(Slot))

pub opaque type Program {
  Program(functions: Functions)
}

pub fn init(level: level.Level) -> Program {
  let functions =
    level.functions
    |> list.index_map(fn(size, index) {
      #(index, list.repeat(EmptySlot, times: size))
    })
    |> dict.from_list
  Program(functions)
}

pub fn fill_slots(
  program: Program,
  function_index: Int,
  slots: List(Slot),
) -> Program {
  let functions = dict.insert(program.functions, function_index, slots)
  Program(functions:)
}

pub fn get_functions(program: Program) -> Functions {
  program.functions
}

pub type Condition {
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

pub type Instruction {
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

pub fn slots_to_instructions(slots: List(Slot)) -> List(Instruction) {
  do_slots_to_instructions(slots, [])
  |> list.reverse
}

fn do_slots_to_instructions(
  slots: List(Slot),
  instructions: List(Instruction),
) -> List(Instruction) {
  case slots {
    [] -> instructions
    [slot, ..rest] -> {
      case slot {
        EmptySlot -> do_slots_to_instructions(rest, instructions)
        Filled(instruction) -> {
          let instructions = [instruction, ..instructions]
          do_slots_to_instructions(rest, instructions)
        }
      }
    }
  }
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
  |> dict.to_list
  |> list.map(fn(value) {
    let #(index, slots) = value
    let slots =
      slots
      |> list.map(slot_to_string)
      |> string.join(with: ", ")

    "F" <> int.to_string(index) <> ": [" <> slots <> "]"
  })
  |> string.join(with: "\n")
}
