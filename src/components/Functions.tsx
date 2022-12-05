import {Component, For, onCleanup, onMount} from "solid-js";
import {produce} from "solid-js/store";
import { gameStore, InstructionType } from "../store";
import FnInstruction from "./FnInstruction";

const Functions: Component = () => {
  const [state, setState] = gameStore

  const increaseFnIndex = (fnIndex: number) => {
    const result = fnIndex + 1
    if (result >= state.game.functions.length) {
      return 0
    }
    return result
  }
  const decreaseFnIndex = (fnIndex: number) => {
    const result = fnIndex - 1
    if (result < 0) {
      return state.game.functions.length - 1
    }
    return result
  }

  const onKeyup = (e: KeyboardEvent) => {
    const { game: { selectedInstruct: { fnIndex, instructIndex } } } = state
    setState(produce(s => {
      let nextFn = fnIndex
      let nextIn = instructIndex

      if (e.key === "ArrowDown") {
        nextFn = increaseFnIndex(nextFn)
      } else if (e.key === "ArrowUp") {
        nextFn = decreaseFnIndex(nextFn)
      } else if (e.key === "ArrowLeft") {
        nextIn -= 1
        if (nextIn < 0) {
          nextFn = decreaseFnIndex(fnIndex)
          nextIn = s.game.functions[nextFn].length - 1
        }
      } else if (e.key === "ArrowRight") {
        nextIn += 1
        if (nextIn >= s.game.functions[fnIndex].length) {
          nextIn = 0
          nextFn = increaseFnIndex(fnIndex)
        }
      } else if (e.key === "Backspace") {
        const instruction = s.game.functions[nextFn][nextIn]
        s.game.functions[nextFn][nextIn] = {
          ...instruction, type: InstructionType.PASS
        }
      }

      s.game.selectedInstruct = {
        fnIndex: nextFn,
        instructIndex: nextIn
      }
    }))
  }
  onMount(() => {
    document.addEventListener("keyup", onKeyup)
  })
  onCleanup(() => {
    document.removeEventListener("keyup", onKeyup)
  })

  return (
    <div>
      <For each={state.game.functions}>
        {(fn, i) => (
          <div class="flex">
            <div class="fn-block">
              f{i()}
            </div>
            <For each={fn}>
              {(instruction, j) => (
                <FnInstruction
                  fni={i()}
                  ini={j()}
                  instruction={instruction}
                />
              )}
            </For>
          </div>
        )}
      </For>
    </div>
  )
}

export default Functions
