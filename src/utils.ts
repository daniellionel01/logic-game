import { createStore, SetStoreFunction, Store } from "solid-js/store"
import { createEffect } from "solid-js";

export function makeArrayWith(l: number, n: number) {
  return Array.from(Array(l).keys()).map((_, i) => n)
}

export function makeArray(l: number) {
  return Array.from(Array(l).keys()).map((_, i) => i)
}

export function createLocalStore<T extends object>(
  name: string,
  init: T
): [Store<T>, SetStoreFunction<T>] {
  const localState = localStorage.getItem(name)
  const [state, setState] = createStore<T>(
    localState ? JSON.parse(localState) : init
  )
  createEffect(() => localStorage.setItem(name, JSON.stringify(state)))
  return [state, setState]
};
