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

    if (e.key.startsWith("Arrow")) {
      setState(produce(s => {

        let nextFn = fnIndex
        let nextIn = instructIndex

        if (fnIndex === -1) {
          nextFn = 0
          nextIn = 0
        } else if (e.key === "ArrowDown") {
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
        }

        s.game.selectedInstruct = {
          fnIndex: nextFn,
          instructIndex: nextIn
        }
      }))
    } else if (e.key === "Backspace") {
      setState(produce(s => {
        const { fnIndex, instructIndex } = s.game.selectedInstruct
        const instruction = s.game.functions[fnIndex][instructIndex]
        s.game.functions[fnIndex][instructIndex] = {
          ...instruction, type: InstructionType.PASS
        }
      }))
    }
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
