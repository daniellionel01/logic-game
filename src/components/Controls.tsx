import {Component, createEffect, createMemo} from "solid-js";
import {produce} from "solid-js/store";
import {useLevel} from "../context/Level";
import {calculateStack, gameStore, InstructionType} from "../store";

const Controls: Component = () => {
  const [state, setState] = gameStore

  const { level, won, lost } = useLevel()

  const emptyStack = createMemo(() => {
    const nonPass = state.game.stack.find(s => s.type !== InstructionType.PASS)
    return !nonPass
  })

  const playDisabled = createMemo(() => {
    return won() || lost() || emptyStack() || state.game.step > 0
  })
  const stepDisabled = createMemo(() => {
    return won() || lost() || emptyStack() || state.game.running
  })
  const stopDisabled = createMemo(() => {
    return won() || state.game.step === 0
  })

  const onPlay = () => {
    setState(produce(s => {
      s.game.running = true
    }))
  }
  const onStep = () => {}
  const onStop = () => {
    setState(produce(s => {
      s.game.running = false
      s.game.step = 0

      s.game.ship = { ...level().ship }
      s.game.starsCollected = []
    }))
    calculateStack(setState)
  }

  return (
    <div class="flex">
      <button class="aspect-square text-lg w-8 disabled:text-gray-400" disabled={playDisabled()} onClick={onPlay}>
        <div class="flex justify-center items-center">
          <i class="fas fa-play"></i>
        </div>
      </button>
      <button class="aspect-square text-lg w-8 disabled:text-gray-400" disabled={stepDisabled()} onClick={onStep}>
        <div class="flex justify-center items-center">
          <i class="fas fa-step-forward"></i>
        </div>
      </button>
      <button class="aspect-square text-lg w-8 disabled:text-gray-400" disabled={stopDisabled()} onClick={onStop}>
        <div class="flex justify-center items-center">
          <i class="fas fa-stop"></i>
        </div>
      </button>
    </div>
  )
}

export default Controls;
