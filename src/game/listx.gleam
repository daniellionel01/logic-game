
pub fn get_index(list: List(a), index: Int) -> Result(a, Nil) {
  case list {
    [] -> Error(Nil)
    [el, ..rest] -> {
      case index {
        0 -> Ok(el)
        _ -> get_index(rest, index-1)
      }
    }
  }
}
