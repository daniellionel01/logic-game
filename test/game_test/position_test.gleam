import birdie
import game/position.{Position}
import gleam/list
import gleam/string

pub fn position_sort_ascending_by_row_and_column_test() {
  [
    Position(row: 1, column: 1),
    Position(row: 1, column: 2),
    Position(row: 1, column: 3),
    Position(row: 1, column: 4),
    Position(row: 2, column: 1),
    Position(row: 2, column: 2),
    Position(row: 2, column: 3),
    Position(row: 2, column: 4),
    Position(row: 3, column: 1),
    Position(row: 3, column: 2),
    Position(row: 3, column: 3),
    Position(row: 3, column: 4),
  ]
  |> list.sort(position.compare)
  |> list.map(position.to_string)
  |> string.join(with: "\n")
  |> birdie.snap(title: "positions order ascending first by row then by column")
}
