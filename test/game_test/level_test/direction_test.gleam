import game/level/direction

/// Rotating twice clockwise should invert the direction
///
/// North -> South
/// South -> North
/// East -> West
/// West -> East
///
pub fn rotate_twice_clockwise_test() {
  let dir =
    direction.North
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.South

  let dir =
    direction.South
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.North

  let dir =
    direction.West
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.East

  let dir =
    direction.East
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.West
}

/// Rotating twice counter clockwise should invert the direction
///
/// North -> South
/// South -> North
/// East -> West
/// West -> East
///
pub fn rotate_twice_counter_clockwise_test() {
  let dir =
    direction.North
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.South

  let dir =
    direction.South
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.North

  let dir =
    direction.West
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.East

  let dir =
    direction.East
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.West
}

/// Rotating four times clockwise should yield the same direction
///
/// North -> North
/// South -> South
/// East -> East
/// West -> West
///
pub fn rotate_four_times_clockwise_test() {
  let dir =
    direction.North
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.North

  let dir =
    direction.East
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.East

  let dir =
    direction.South
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.South

  let dir =
    direction.West
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
    |> direction.rotate_clockwise
  assert dir == direction.West
}

/// Rotating four times counter clockwise should yield the same direction
///
/// North -> North
/// South -> South
/// East -> East
/// West -> West
///
pub fn rotate_four_times_counter_clockwise_test() {
  let dir =
    direction.North
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.North

  let dir =
    direction.East
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.East

  let dir =
    direction.South
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.South

  let dir =
    direction.West
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
    |> direction.rotate_counter_clockwise
  assert dir == direction.West
}
