import {Component, createMemo, For} from "solid-js";
import {makeArray} from "../utils";
import Cell from "./Cell";
import {useLevel} from "../context/Level";

const Grid: Component = () => {
  const { width, height } = useLevel()

  const rows = createMemo(() => makeArray(height()))
  const cols = createMemo(() => makeArray(width()))

  return (
    <div class="flex">
      <div class="grid gap-1" style={`grid-template-columns: repeat(${width()}, 1fr);`}>
        <For each={rows()}>
          {row => (
            <For each={cols()}>
              {col => <Cell row={row} col={col} />}
            </For>
          )}
        </For>
      </div>
    </div>
  )
}

export default Grid
