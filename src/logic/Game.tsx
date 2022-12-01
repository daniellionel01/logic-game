import {Component, createEffect, createMemo, createSignal, on, onCleanup, ParentProps} from "solid-js"
import {produce} from "solid-js/store"
import {useLevel} from "../context/Level"
import {CallFnInstruction, gameStore, InstructionType, PaintColorInstruction} from "../store"

const Game: Component = (props: ParentProps) => {
  const [state, setState] = gameStore

  const { level, won, lost } = useLevel()

  const tick = () => {
    setState(produce((s) => {
      s.game.step += 1

      const ship = s.game.ship;

      const nextInstruction = { ...s.game.stack[0] }
      s.game.stack.splice(0, 1)

      if (!!nextInstruction.condColor && nextInstruction.condColor !== "NONE") {
        const cell = state.game.cells.find(c => c.row === ship.row && c.col === ship.col)
        if (cell && cell.color !== nextInstruction.condColor) {
          return;
        }
      }

      if (nextInstruction.type === InstructionType.FORWARD) {
        if (ship.dir === "TOP") {
          s.game.ship = { ...ship, row: ship.row-1 }
        } else if (ship.dir === "BOTTOM") {
          s.game.ship = { ...ship, row: ship.row+1 }
        } else if (ship.dir === "LEFT") {
          s.game.ship = { ...ship, col: ship.col-1 }
        } else if (ship.dir === "RIGHT") {
          s.game.ship = { ...ship, col: ship.col+1 }
        }
      } else if (nextInstruction.type === InstructionType.ROT_L) {
        if (ship.dir === "RIGHT") {
          s.game.ship = { ...ship, dir: "TOP" }
        } else if (ship.dir === "BOTTOM") {
          s.game.ship = { ...ship, dir: "RIGHT" }
        } else if (ship.dir === "LEFT") {
          s.game.ship = { ...ship, dir: "BOTTOM" }
        } else if (ship.dir === "TOP") {
          s.game.ship = { ...ship, dir: "LEFT" }
        }
      } else if (nextInstruction.type === InstructionType.ROT_R) {
        if (ship.dir === "RIGHT") {
          s.game.ship = { ...ship, dir: "BOTTOM" }
        } else if (ship.dir === "BOTTOM") {
          s.game.ship = { ...ship, dir: "LEFT" }
        } else if (ship.dir === "LEFT") {
          s.game.ship = { ...ship, dir: "TOP" }
        } else if (ship.dir === "TOP") {
          s.game.ship = { ...ship, dir: "RIGHT" }
        }
      } else if (nextInstruction.type === InstructionType.CALL_FN) {
        const fnIns = nextInstruction as CallFnInstruction
        const instructions = state.game.functions[fnIns.fnIndex].filter(s => s.type !== InstructionType.PASS)
        s.game.stack.unshift(...instructions)
      } else if (nextInstruction.type === InstructionType.PAINT_COLOR) {
        const colorIns = nextInstruction as PaintColorInstruction

        const cell = state.game.cells.find(c => c.row === ship.row && c.col === ship.col)
        if (!cell) return;
        const index = state.game.cells.indexOf(cell)
        s.game.cells[index].color = colorIns.paintColor
      }
    }))
  }

  createEffect(() => {
    const ship = state.game.ship
    const star = level().stars.find(s => s.col === ship.col && s.row === ship.row)
    if (!star) return;

    const collected = state.game.starsCollected.find(s => s.col === star.col && s.row === star.row)
    if (collected) return;

    setState(produce(s => {
      s.game.starsCollected.push({ ...star })
    }))
  })

  const [timer, setTimer] = createSignal<number>(null)

  createEffect(() => {
    const gameEnded = won() || lost()
    if (gameEnded && timer() !== null) {
      clearInterval(timer())
      setTimer(null)
      return;
    } else if (gameEnded && timer() === null) {
      return
    }

    if (!state.game.running && timer() !== null) {
      clearInterval(timer())
      setTimer(null)
    } else if (state.game.running && timer() === null) {
      const i = setInterval(tick, 500)
      setTimer(i)
    }
  })
  onCleanup(() => {
    clearInterval(timer())
    setTimer(null)
  })

  return (
    <div>
      {props.children}
    </div>
  )
}

export default Game
