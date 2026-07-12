export function every(interval, cb) {
  return window.setInterval(cb, interval);
}

export function clear_interval(interval_id) {
  window.clearInterval(interval_id);
}
