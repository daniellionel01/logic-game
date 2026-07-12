import game/level
import game/level/color
import game/level/direction
import game/level/seed
import game/listx
import game/position
import game/program
import game/runtime
import game/web/icon
import game/web/interval
import gleam/dict
import gleam/int
import gleam/list
import lustre
import lustre/attribute
import lustre/effect
import lustre/element
import lustre/element/html
import lustre/event

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

type GameState {
  Editing(selected_function: Int, selected_slot: Int)
  Running(interval_id: interval.IntervalId)
}

type Model {
  Model(level_number: Int, runtime: runtime.Runtime, state: GameState)
}

type Message {
  /// Used in development and for debugging purposes
  ConsoleLog(String)

  UserClickedAction(program.Action)
  UserClickedCondition(color.Color)
  UserClickedSlot(selected_function: Int, selected_slot: Int)

  UserClickedStart
  ProgramLoopStarted(interval_id: interval.IntervalId)
  UserClickedStop
}

fn init(_: Nil) -> #(Model, effect.Effect(b)) {
  let assert Ok(level) = level.parse(seed.level_7)
  let runtime = runtime.init(level)

  let state = Editing(selected_function: 0, selected_slot: 0)
  #(Model(level_number: 1, runtime:, state:), effect.none())
}

fn update(model: Model, message: Message) -> #(Model, effect.Effect(Message)) {
  case message {
    ConsoleLog(message) -> {
      echo message
      #(model, effect.none())
    }
    UserClickedAction(action) -> {
      let assert Editing(selected_function:, selected_slot:) = model.state

      let assert Ok(function) =
        dict.get(model.runtime.program.functions, selected_function)
      let assert Ok(slot) = listx.get_index(function, selected_slot)
      let slot = case slot {
        program.EmptySlot -> {
          program.Filled(program.Instruction(action, program.Always))
        }
        program.Filled(instruction) -> {
          case instruction {
            program.Instruction(action:, condition: program.Always) -> {
              program.Filled(program.Instruction(action, program.Always))
            }
            program.Instruction(action:, condition: program.WhenOn(color)) -> {
              program.Filled(program.Instruction(action, program.WhenOn(color)))
            }
          }
        }
      }

      let assert Ok(program) =
        program.fill_slot(
          model.runtime.program,
          slot_index: selected_slot,
          function_index: selected_function,
          slot:,
        )
      let runtime = runtime.Runtime(..model.runtime, program:)
      let model = Model(..model, runtime:)
      #(model, effect.none())
    }
    UserClickedCondition(color) -> {
      let assert Editing(selected_function:, selected_slot:) = model.state

      let assert Ok(function) =
        dict.get(model.runtime.program.functions, selected_function)
      let assert Ok(slot) = listx.get_index(function, selected_slot)
      let slot = case slot {
        program.EmptySlot -> {
          program.EmptySlot
        }
        program.Filled(instruction) -> {
          case instruction {
            program.Instruction(action:, condition: program.Always) -> {
              program.Filled(program.Instruction(action, program.WhenOn(color)))
            }
            program.Instruction(action:, condition: program.WhenOn(_)) -> {
              program.Filled(program.Instruction(action, program.WhenOn(color)))
            }
          }
        }
      }

      let assert Ok(program) =
        program.fill_slot(
          model.runtime.program,
          slot_index: selected_slot,
          function_index: selected_function,
          slot:,
        )
      let runtime = runtime.Runtime(..model.runtime, program:)
      let model = Model(..model, runtime:)
      #(model, effect.none())
    }
    UserClickedSlot(selected_function:, selected_slot:) -> {
      let state = Editing(selected_function:, selected_slot:)
      let model = Model(..model, state:)
      #(model, effect.none())
    }
    UserClickedStart -> {
      #(model, start_program_execution())
    }
    ProgramLoopStarted(interval_id) -> {
      let model = Model(..model, state: Running(interval_id))
      #(model, effect.none())
    }
    UserClickedStop -> {
      let assert Running(interval_id:) = model.state
      interval.clear(interval_id)

      let state = Editing(selected_function: 0, selected_slot: 0)
      let model = Model(..model, state:)
      #(model, effect.none())
    }
  }
}

fn start_program_execution() -> effect.Effect(Message) {
  use dispatch <- effect.from()
  let id =
    interval.do_every(1000, fn() {
      echo "here"
      Nil
    })
  dispatch(ProgramLoopStarted(id))
}

fn view(model: Model) -> element.Element(Message) {
  html.div([attribute.class("p-20 bg-gray-100 w-screen h-full min-h-screen")], [
    html.header([attribute.class("flex justify-between items-end")], [
      html.h1([attribute.class("font-bold text-2xl")], [
        html.text("Level " <> int.to_string(model.level_number)),
      ]),
      html.div([attribute.class("flex gap-8")], [
        html.button([attribute.class("cursor-pointer hover:underline")], [
          html.text("Help"),
        ]),
        html.button([attribute.class("cursor-pointer hover:underline")], [
          html.text("Levels"),
        ]),
      ]),
    ]),
    html.hr([attribute.class("my-8")]),
    html.main([attribute.class("space-y-8")], [
      html.div([attribute.class("flex gap-4")], [
        stack(model.runtime),
        controls(model),
      ]),
      grid(model.runtime),
      function_slots(model),
      case model.state {
        Editing(_, _) -> {
          function_editor()
        }
        Running(_) -> {
          element.fragment([])
        }
      },
    ]),
  ])
}

fn function_editor() -> element.Element(Message) {
  let action = fn(
    attrs: List(attribute.Attribute(Message)),
    action: program.Action,
    el: element.Element(Message),
  ) {
    html.button(
      [
        attribute.class("border border-black p-2 cursor-pointer"),
        event.on_click(UserClickedAction(action)),
        ..attrs
      ],
      [el],
    )
  }
  let condition = fn(
    attrs: List(attribute.Attribute(Message)),
    color: color.Color,
    el: element.Element(Message),
  ) {
    html.button(
      [
        attribute.class("border border-black p-2 cursor-pointer"),
        event.on_click(UserClickedCondition(color)),
        ..attrs
      ],
      [el],
    )
  }

  html.div(
    [
      attribute.class(
        "grid grid-cols-[repeat(3,3rem)] auto-rows-[3rem] [&>*]:grid [&>*]:place-items-center",
      ),
    ],
    [
      action([], program.RotateLeft, icon.rotate_left()),
      action([], program.Forward, icon.arrow_up()),
      action([], program.RotateRight, icon.rotate_right()),
      action(
        [attribute.class("font-semibold")],
        program.Call(0),
        html.text("F0"),
      ),
      action(
        [attribute.class("font-semibold")],
        program.Call(1),
        html.text("F1"),
      ),
      action(
        [attribute.class("font-semibold")],
        program.Call(2),
        html.text("F2"),
      ),
      action(
        [attribute.class("text-red-500")],
        program.Fill(color.Red),
        icon.paint_roller(),
      ),
      action(
        [attribute.class("text-blue-500")],
        program.Fill(color.Blue),
        icon.paint_roller(),
      ),
      action(
        [attribute.class("text-green-500")],
        program.Fill(color.Green),
        icon.paint_roller(),
      ),

      condition(
        [attribute.class("bg-red-500")],
        color.Red,
        html.div([attribute.class("w-6 h-6")], []),
      ),
      condition(
        [attribute.class("bg-blue-500")],
        color.Blue,
        html.div([attribute.class("w-6 h-6")], []),
      ),
      condition(
        [attribute.class("bg-green-500")],
        color.Green,
        html.div([attribute.class("w-6 h-6")], []),
      ),
    ],
  )
}

fn function_slots(model: Model) -> element.Element(Message) {
  let #(selected_function, selected_slot) = case model.state {
    Editing(selected_function:, selected_slot:) -> {
      #(selected_function, selected_slot)
    }
    Running(_) -> {
      #(-1, -1)
    }
  }

  let functions =
    model.runtime.program.functions
    |> dict.to_list
    |> list.sort(fn(a, b) { int.compare(a.0, b.0) })

  let functions =
    list.map(functions, fn(func) {
      let #(func_index, slots) = func

      let slots =
        list.index_map(slots, fn(slot, slot_index) {
          let selected =
            func_index == selected_function && slot_index == selected_slot
          let attrs = [
            attribute.class("w-full h-full cursor-pointer"),
            attribute.classes([#("bg-gray-300", selected)]),
            event.on_click(UserClickedSlot(
              selected_function: func_index,
              selected_slot: slot_index,
            )),
          ]

          case slot {
            program.EmptySlot -> {
              html.div(attrs, [])
            }
            program.Filled(instruction) -> {
              instruction_component(instruction, attrs)
            }
          }
        })

      let label =
        html.div([attribute.class("font-semibold")], [
          html.text("F" <> int.to_string(func_index)),
        ])

      let with_container =
        [label, ..slots]
        |> list.map(fn(el) {
          html.div(
            [
              attribute.class(
                "w-12 h-12 border flex items-center justify-center",
              ),
            ],
            [el],
          )
        })

      html.div([attribute.class("flex")], with_container)
    })

  html.div([attribute.class("space-y-1")], functions)
}

fn controls(model: Model) -> element.Element(Message) {
  html.div([attribute.class("flex gap-4 border p-4")], [
    case model.state {
      Editing(_, _) -> {
        html.button(
          [
            attribute.class(
              "cursor-pointer disabled:text-gray-400 disabled:cursor-not-allowed",
            ),
            event.on_click(UserClickedStart),
          ],
          [icon.play()],
        )
      }
      Running(_) -> {
        html.button(
          [
            attribute.class(
              "cursor-pointer disabled:text-gray-400 disabled:cursor-not-allowed",
            ),
            event.on_click(UserClickedStop),
          ],
          [icon.square()],
        )
      }
    },
  ])
}

fn stack(runtime: runtime.Runtime) -> element.Element(Message) {
  let stack = list.map(runtime.stack, instruction_component(_, []))

  html.div([attribute.class("w-full border p-4 font-semibold space-y-4")], [
    html.p([], [html.text("Execution Stack")]),
    html.div([attribute.class("flex gap-4")], stack),
  ])
}

fn grid(runtime: runtime.Runtime) -> element.Element(Message) {
  let size = level.size(runtime.cells)

  let cells =
    list.repeat(0, times: size.columns * size.rows)
    |> list.index_map(fn(_, index) { position.from_index(index, size.columns) })
    |> list.map(cell(runtime, _))

  html.div(
    [
      attribute.class("grid gap-1"),
      attribute.styles([
        #(
          "grid-template-columns",
          "repeat(" <> int.to_string(size.columns) <> ", var(--cell-size))",
        ),
      ]),
    ],
    cells,
  )
}

fn background_color_class(color: color.Color) -> String {
  case color {
    color.Red -> "bg-red-400"
    color.Blue -> "bg-blue-400"
    color.Green -> "bg-green-400"
  }
}

fn foreground_color_class(color: color.Color) -> String {
  case color {
    color.Red -> "text-red-500"
    color.Blue -> "text-blue-500"
    color.Green -> "text-green-500"
  }
}

fn instruction_component(
  instruction: program.Instruction,
  attrs: List(attribute.Attribute(Message)),
) -> element.Element(Message) {
  let icon =
    html.div([attribute.class("w-6 h-6")], [action_icon(instruction.action)])
  let color_tag = case instruction {
    program.Instruction(action: _, condition: program.WhenOn(color)) -> {
      html.div(
        [
          attribute.class("w-full h-2 rounded-sm"),
          attribute.classes([#(background_color_class(color), True)]),
        ],
        [],
      )
    }
    program.Instruction(action: _, condition: program.Always) -> {
      html.div([attribute.class("w-full h-2")], [])
    }
  }
  html.div([attribute.class("p-1 space-y-1"), ..attrs], [icon, color_tag])
}

fn action_icon(action: program.Action) -> element.Element(Message) {
  case action {
    program.Forward -> icon.arrow_up()
    program.RotateRight -> icon.rotate_right()
    program.RotateLeft -> icon.rotate_left()
    program.Fill(color) ->
      html.div([attribute.class(foreground_color_class(color))], [
        icon.paint_roller(),
      ])
    program.Call(index) -> {
      let index = int.to_string(index)
      html.div([], [html.text("F" <> index)])
    }
  }
}

fn cell(
  runtime: runtime.Runtime,
  position: position.Position,
) -> element.Element(Message) {
  let cell =
    list.find(runtime.cells, fn(cell) {
      position.equal(cell.position, position)
    })

  let background_color = case cell {
    Error(_) -> "bg-white"
    Ok(cell) -> background_color_class(cell.color)
  }

  let star =
    list.find(runtime.remaining_stars, fn(star) {
      position.equal(star.position, position)
    })
  let star = case star {
    Error(_) -> element.fragment([])
    Ok(_) -> {
      html.div([attribute.class("text-white")], [icon.star()])
    }
  }

  let player = runtime.player
  let player = case position.equal(player.position, position) {
    False -> element.fragment([])
    True -> {
      let degrees = case player.direction {
        direction.North -> 0
        direction.East -> 90
        direction.South -> 180
        direction.West -> 270
      }
      let rotate = int.to_string(degrees) <> "deg"
      html.div(
        [attribute.class("text-white"), attribute.style("rotate", rotate)],
        [icon.player()],
      )
    }
  }

  html.div(
    [
      attribute.class("rounded-2xl flex justify-center items-center"),
      attribute.classes([#(background_color, True)]),
      attribute.styles([
        #("width", "var(--cell-size)"),
        #("height", "var(--cell-size)"),
        #(
          "box-shadow",
          "0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05);",
        ),
      ]),
    ],
    [star, player],
  )
}
