import { Component, createMemo } from "solid-js"
import { Cell as ICell, makeEmptyCell } from "../store";
import {useLevel} from "./Level";

export interface CellProps {
  row: number;
  col: number;
}

const Cell: Component<CellProps> = (props: CellProps) => {
  const { row, col } = props

  const [level, width, _height] = useLevel()

  const index = createMemo(() => col+row*width())

  const cell = createMemo<ICell>(() => {
    return level().cells[index()] || makeEmptyCell(row, col)
  })

  return (
    <div
      class="w-14 border-2 rounded-2xl aspect-square bg-white"
      style="box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05);"
    >
    </div>
  )
}
export default Cell
