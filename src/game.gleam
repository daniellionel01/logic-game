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
import gleam/list
import lustre
import lustre/attribute
import lustre/effect
import lustre/element
import lustre/element/html

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

type GameState {
  Editing
  Running
}

type Model {
  Model(level_number: Int, runtime: runtime.Runtime, state: GameState)
}

type Message

fn init(_: Nil) -> #(Model, effect.Effect(b)) {
  let assert Ok(level) = level.parse(seed.level_7)
  let runtime = runtime.init(level)

  #(Model(level_number: 1, runtime:, state: Editing), effect.none())
}

fn update(model: Model, message: Message) -> #(Model, effect.Effect(Message)) {
  #(model, effect.none())
}

fn view(model: Model) -> element.Element(Message) {
  html.div([attribute.class("p-20 bg-gray-100 w-screen h-screen")], [
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
  let functions =
    runtime.program(model.runtime).functions
    |> dict.to_list
    |> list.sort(fn(a, b) { int.compare(a.0, b.0) })

  let functions =
    list.map(functions, fn(func) {
      let #(index, slots) = func

      let slots =
        [
          program.Filled(program.when_on(color.Red, program.Forward)),
          program.Filled(program.always(program.Fill(color.Red))),
          program.Filled(program.always(program.Call(1))),
        ]
        |> list.map(fn(slot) {
          // list.map(slots, fn(slot) {
          let instruction_el = case slot {
            program.EmptySlot -> {
              element.fragment([])
            }
            program.Filled(instruction) -> {
              instruction_component(instruction)
            }
          }
          html.div([attribute.class("w-6 h-6")], [instruction_el])
        })

      let label =
        html.div([attribute.class("font-semibold")], [
          html.text("F" <> int.to_string(index)),
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

fn stack(runtime: runtime.Runtime) -> element.Element(Message) {
  let stack =
    runtime.stack(runtime)
    |> list.map(instruction_component)

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
  html.div([attribute.class("p-1 space-y-1")], [icon, color_tag])
}

fn action_icon(action: program.Action) -> element.Element(Message) {
  case action {
    program.Forward -> icon.arrow_up()
    program.RotateRight -> icon.rotate_cw()
    program.RotateLeft -> icon.rotate_ccw()
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
