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

type Model {
  Model
}

type Message

fn init(_: Nil) -> #(Model, effect.Effect(b)) {
  #(Model, effect.none())
}

fn update(model: Model, message: Message) -> #(Model, effect.Effect(Message)) {
  #(model, effect.none())
}

fn view(model: Model) -> element.Element(Message) {
  html.div([attribute.class("p-10")], [html.text("lorem")])
}
