import game/level
import game/level/color
import game/level/direction
import game/level/seed
import game/position
import game/program
import game/runtime
import game/web/icon
import gleam/dict
import gleam/int
import gleam/io
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
  Running
}

type Model {
  Model(level_number: Int, runtime: runtime.Runtime, state: GameState)
}

type Message {
  /// Used in development and for debugging purposes
  ConsoleLog(String)

  UserPressedAction(program.Action)
  UserPressedCondition(color.Color)
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
      io.println(message)
    }
    UserPressedAction(action) -> {
      echo action as "action"
      Nil
    }
    UserPressedCondition(color) -> {
      echo color as "color"
      Nil
    }
  }
  #(model, effect.none())
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
      stack(model.runtime),
      grid(model.runtime),
      function_editor(model),
    ]),
  ])
}

fn function_editor(model: Model) -> element.Element(Message) {
  let assert Editing(selected_function:, selected_slot:) = model.state

  let functions =
    runtime.program(model.runtime).functions
    |> dict.to_list
    |> list.sort(fn(a, b) { int.compare(a.0, b.0) })

  let functions =
    list.map(functions, fn(func) {
      let #(func_index, slots) = func

      let slots =
        list.index_map(slots, fn(slot, slot_index) {
          let attrs = case
            func_index == selected_function,
            slot_index == selected_slot
          {
            True, True -> [attribute.class("bg-gray-300")]
            _, _ -> []
          }
          case slot {
            program.EmptySlot -> {
              html.div([attribute.class("w-full h-full"), ..attrs], [])
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

  let action = fn(
    attrs: List(attribute.Attribute(Message)),
    action: program.Action,
    el: element.Element(Message),
  ) {
    html.button(
      [
        attribute.class("border border-black p-2 cursor-pointer"),
        event.on_click(UserPressedAction(action)),
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
        event.on_click(UserPressedCondition(color)),
        ..attrs
      ],
      [el],
    )
  }

  let actions =
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

  html.div([attribute.class("space-y-4")], [
    html.div([attribute.class("space-y-1")], functions),
    actions,
  ])
}

fn stack(runtime: runtime.Runtime) -> element.Element(Message) {
  let stack =
    runtime.stack(runtime)
    // [
    //   program.always(program.Forward),
    //   program.always(program.RotateRight),
    //   program.always(program.RotateLeft),
    //   program.always(program.Call(1)),
    //   program.always(program.Fill(color.Red)),
    //   program.when_on(color.Red, program.Forward),
    //   program.when_on(color.Red, program.RotateRight),
    //   program.when_on(color.Red, program.RotateLeft),
    //   program.when_on(color.Red, program.Call(1)),
    //   program.when_on(color.Red, program.Fill(color.Red)),
    // ]
    |> list.map(instruction_component(_, []))

  html.div([attribute.class("w-full border p-4 font-semibold space-y-4")], [
    html.p([], [html.text("Execution Stack")]),
    html.div([attribute.class("flex gap-4")], stack),
  ])
}

fn grid(runtime: runtime.Runtime) -> element.Element(Message) {
  let size = level.size(runtime.cells(runtime))

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
    list.find(runtime.cells(runtime), fn(cell) {
      position.equal(cell.position, position)
    })

  let background_color = case cell {
    Error(_) -> "bg-white"
    Ok(cell) -> background_color_class(cell.color)
  }

  let star =
    list.find(runtime.remaining_stars(runtime), fn(star) {
      position.equal(star.position, position)
    })
  let star = case star {
    Error(_) -> element.fragment([])
    Ok(_) -> {
      html.div([attribute.class("text-white")], [icon.star()])
    }
  }

  let player = runtime.player(runtime)
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
