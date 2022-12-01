import { Component, createEffect, createMemo, Show } from "solid-js"
import { Cell as ICell, Color, gameStore, makeEmptyCell } from "../store";
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

  const [state] = gameStore
  const { level } = useLevel()

  const cell = createMemo<ICell>(() => {
    const found = state.game.cells.find(c => c.row === row && c.col === col)
    return found || makeEmptyCell(row, col)
  })
  const bg = createMemo(() => {
    return COLORS[cell().color]
  })

  const isStar = createMemo<boolean>(() => {
    const star = level().stars.find(s => s.row === row && s.col === col)
    if (!star) return false;

    const collected = state.game.starsCollected.find(s => s.col === star.col && s.row === star.row)
    return !collected
  })

  const isShip = createMemo<boolean>(() => {
    const s = state.game.ship
    return s.col === col && s.row === row
  })

  const rotate = createMemo<string>(() => {
    if (!isShip()) return ""

    const s = state.game.ship
    if (s.dir === "TOP") {
      return "-rotate-90"
    } else if (s.dir === "LEFT") {
      return "rotate-180"
    } else if (s.dir === "RIGHT") {
      return "rotate-0"
    } else if (s.dir === "BOTTOM") {
      return "rotate-90"
    }
    throw new Error("Missing rotation value")
  })

  const color = createMemo(() => {
    return cell().color === "NONE" ? "text-black" : "text-white"
  })

  return (
    <div
      class={`w-14 flex justify-center items-center rounded-2xl aspect-square text-xl ${bg()} ${rotate()} ${color()}`}
      style="box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05);"
    >
      <Show when={isStar()}>
        <i class="fas fa-star"></i>
      </Show>
      <Show when={isShip()}>
        <i class="fas fa-space-shuttle"></i>
      </Show>
    </div>
  )
}
export default Cell
