import {Component, createMemo} from "solid-js";
import {useLevel} from "../context/Level";
import {gameStore} from "../store";

const Controls: Component = () => {
  const [state] = gameStore

  const { won, lost } = useLevel()

  const playDisabled = createMemo(() => {
    return state.game.stack.length === 0
  })
  const stepDisabled = createMemo(() => {
    return state.game.stack.length === 0 || state.game.running
  })
  const stopDisabled = createMemo(() => {
    return state.game.step === 0
  })

  return (
    <div class="flex">
      <button class="aspect-square text-lg w-8 disabled:text-gray-400" disabled={playDisabled()}>
        <div class="flex justify-center items-center">
          <i class="fas fa-play"></i>
        </div>
      </button>
      <button class="aspect-square text-lg w-8 disabled:text-gray-400" disabled={stepDisabled()}>
        <div class="flex justify-center items-center">
          <i class="fas fa-step-forward"></i>
        </div>
      </button>
      <button class="aspect-square text-lg w-8 disabled:text-gray-400" disabled={stopDisabled()}>
        <div class="flex justify-center items-center">
          <i class="fas fa-stop"></i>
        </div>
      </button>
    </div>
  )
}

export default Controls;
