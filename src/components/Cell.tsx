import { Component, createMemo, Show } from "solid-js"
import { Cell as ICell, Color, makeEmptyCell } from "../store";
import {useLevel} from "../context/Level";

export interface CellProps {
  row: number;
  col: number;
}

const COLORS: Record<Color, string> = {
  "NONE": "bg-white",
  "RED": "bg-red-500",
  "BLUE": "bg-blue-500",
  "GREEN": "bg-green-500"
}

const Cell: Component<CellProps> = (props: CellProps) => {
  const { row, col } = props

  const [level, width, _height] = useLevel()

  const cell = createMemo<ICell>(() => {
    const found = level().cells.find(c => c.row === row && c.col === col)
    return found || makeEmptyCell(row, col)
  })
  const bg = createMemo(() => {
    return COLORS[cell().color]
  })

  const isStar = createMemo<boolean>(() => {
    return !!level().stars.find(s => s.row === row && s.col === col)
  })

  return (
    <div
      class={`w-14 border-2 rounded-2xl aspect-square ${bg()}`}
      classList={{ "flex justify-center items-center text-white": isStar()}}
      style="box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05);"
    >
      <Show when={isStar()}>
        <i class="fas fa-star"></i>
      </Show>
    </div>
  )
}
export default Cell
