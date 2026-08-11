pub opaque type IntervalId {
  IntervalId(Int)
}

pub fn value(id: IntervalId) -> Int {
  let IntervalId(id) = id
  id
}

pub fn from(id: Int) -> IntervalId {
  IntervalId(id)
}

@external(javascript, "./interval.ffi.mjs", "every")
pub fn do_every(interval: Int, cb: fn() -> Nil) -> IntervalId

@external(javascript, "./interval.ffi.mjs", "clear_interval")
pub fn clear(id: IntervalId) -> Nil
