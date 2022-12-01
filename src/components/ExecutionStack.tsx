import {Component, For} from "solid-js";
import {gameStore} from "../store";
import InstructionSymbol from "./InstructionSymbol";

const ExecutionStack: Component = () => {
  const [state] = gameStore

  return (
    <div class="border-2 border-gray-700 rounded-2xl w-full h-12 flex overflow-hidden">
      <For each={state.game.stack}>
        {ins => (
          <div class="aspect-square h-full">
            <InstructionSymbol
              type={ins.type}
              condColor={ins.condColor}
              fnIndex={ins["fnIndex"]}
              paintColor={ins["paintColor"]}
            />
          </div>
        )}
      </For>
    </div>
  )
}

export default ExecutionStack
