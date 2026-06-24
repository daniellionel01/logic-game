import gleam/dynamic/decode

// We use cardinal directions, because "Left" and "Right"
// are also associated with rotating the player.
//
pub type Direction {
  North
  East
  South
  West
}

pub fn decoder() -> decode.Decoder(Direction) {
  use variant <- decode.then(decode.string)
  case variant {
    "north" | "^" -> decode.success(North)
    "east" | ">" -> decode.success(East)
    "south" | "v" -> decode.success(South)
    "west" | "<" -> decode.success(West)
    _ -> decode.failure(North, "Direction")
  }
}

pub fn to_string(direction: Direction) -> String {
  case direction {
    North -> "^"
    East -> ">"
    South -> "v"
    West -> "<"
  }
}

pub fn rotate_clockwise(direction: Direction) -> Direction {
  case direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}

pub fn rotate_counter_clockwise(direction: Direction) -> Direction {
  case direction {
    North -> West
    East -> North
    South -> East
    West -> South
  }
}
