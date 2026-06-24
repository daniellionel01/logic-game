import gleam/int
import gleam/order

/// A position encodes the row and column of an entity (y and x position).
///
/// They are not zero based and the very top left starts at (1, 1).
///
pub type Position {
  Position(row: Int, column: Int)
}

pub fn compare(a: Position, b: Position) -> order.Order {
  case int.compare(a.row, b.row) {
    order.Lt -> order.Lt
    order.Gt -> order.Gt
    order.Eq -> int.compare(a.column, b.column)
  }
}

/// This creates a string with the format #(row, column)
///
pub fn to_string(position: Position) -> String {
  "#("
  <> int.to_string(position.row)
  <> ","
  <> int.to_string(position.column)
  <> ")"
}
