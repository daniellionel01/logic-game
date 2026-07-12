import { from, value } from "./interval.mjs";

export function every(interval, cb) {
  const id = window.setInterval(cb, interval);
  return from(id);
}

export function clear_interval(interval_id) {
  const id = value(interval_id);
  window.clearInterval(id);
}
