import {Component, createEffect, createMemo, createSignal, on, onCleanup, ParentProps} from "solid-js"
import {produce} from "solid-js/store"
import {useLevel} from "../context/Level"
import {gameStore} from "../store"

const Game: Component = (props: ParentProps) => {
  const [state, setState] = gameStore

  const { level, won, lost } = useLevel()

  const tick = () => {
    setState(produce((s) => {
      const nextInstruction = s.game.stack.pop()

      const ship = s.game.ship;
      s.game.ship = {
        ...ship,
        col: ship.col+1
      }

      s.game.step += 1
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
      const i = setInterval(tick, 1000)
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
