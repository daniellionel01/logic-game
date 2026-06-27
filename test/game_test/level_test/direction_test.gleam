import game/level/direction

/// Rotating to the right twice should invert the direction
///
/// North -> South
/// South -> North
/// East -> West
/// West -> East
///
pub fn rotate_twice_right_test() {
  let dir =
    direction.North
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.South

  let dir =
    direction.South
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.North

  let dir =
    direction.West
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.East

  let dir =
    direction.East
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.West
}

/// Rotating to the left twice should invert the direction
///
/// North -> South
/// South -> North
/// East -> West
/// West -> East
///
pub fn rotate_twice_left_test() {
  let dir =
    direction.North
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.South

  let dir =
    direction.South
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.North

  let dir =
    direction.West
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.East

  let dir =
    direction.East
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.West
}

/// Rotating four times right should yield the same direction
///
/// North -> North
/// South -> South
/// East -> East
/// West -> West
///
pub fn rotate_four_times_right_test() {
  let dir =
    direction.North
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.North

  let dir =
    direction.East
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.East

  let dir =
    direction.South
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.South

  let dir =
    direction.West
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
    |> direction.rotate_right
  assert dir == direction.West
}

/// Rotating four times left should yield the same direction
///
/// North -> North
/// South -> South
/// East -> East
/// West -> West
///
pub fn rotate_four_times_left_test() {
  let dir =
    direction.North
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.North

  let dir =
    direction.East
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.East

  let dir =
    direction.South
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.South

  let dir =
    direction.West
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
    |> direction.rotate_left
  assert dir == direction.West
}
