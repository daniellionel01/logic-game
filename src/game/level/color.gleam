import gleam/dynamic/decode

pub type Color {
  Red
  Blue
  Green
}

pub fn decoder() -> decode.Decoder(Color) {
  use variant <- decode.then(decode.string)
  case variant {
    "red" | "r" | "R" -> decode.success(Red)
    "blue" | "b" | "B" -> decode.success(Blue)
    "green" | "g" | "G" -> decode.success(Green)
    _ -> decode.failure(Red, "Color")
  }
}

pub fn to_string(color: Color) -> String {
  case color {
    Red -> "r"
    Blue -> "b"
    Green -> "g"
  }
}
