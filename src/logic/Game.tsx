import {Component, createEffect, createSignal, onCleanup, ParentProps} from "solid-js"
import {produce} from "solid-js/store"
import {useLevel} from "../context/Level"
import {gameStore, tick} from "../store"

const Game: Component<ParentProps> = (props: ParentProps) => {
  const [state, setState] = gameStore

  const { level, won, lost } = useLevel()

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
      const i = setInterval(() => tick(setState), 500)
      setTimer(i)
    }
  })
  onCleanup(() => {
    clearInterval(timer())
    setTimer(null)
  })

  return (
    <div class="w-screen">
      {props.children}
    </div>
  )
}

export default Game
