import {Component, createEffect, createMemo} from "solid-js";
import {useLevel} from "../context/Level";
import {gameStore, InstructionType} from "../store";

const Controls: Component = () => {
  const [state] = gameStore

  const { won, lost } = useLevel()

  const emptyStack = createMemo(() => {
    const nonPass = state.game.stack.find(s => s.type !== InstructionType.PASS)
    return !nonPass
  })

  const playDisabled = createMemo(() => {
    return won() || lost() || emptyStack()
  })
  const stepDisabled = createMemo(() => {
    return won() || lost() || emptyStack() || state.game.running
  })
  const stopDisabled = createMemo(() => {
    return won() || lost() || state.game.step === 0
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
