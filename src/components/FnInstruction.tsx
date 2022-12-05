import {Component, createEffect, createMemo, Show} from "solid-js";
import {produce} from "solid-js/store";
import {gameStore, Instruction} from "../store";
import Actions from "./Actions";
import InstructionSymbol from "./InstructionSymbol";

interface FnInstructionProps {
  fni: number;
  ini: number;
  instruction: Instruction
}

const FnInstruction: Component<FnInstructionProps> = (props: FnInstructionProps) => {
  const { fni, ini, instruction } = props

  const [state, setState] = gameStore

  const toggleInstruction = () => {
    setState(produce(s => {
      const { game: { selectedInstruct: { fnIndex, instructIndex } } } = s

      if (fni === fnIndex && ini === instructIndex) {
        s.game.selectedInstruct = { fnIndex: -1, instructIndex: -1 }
      } else {
        s.game.selectedInstruct = { fnIndex: fni, instructIndex: ini }
      }
    }))
  }

  const isSelected = createMemo(() => {
    const { game: { selectedInstruct: { fnIndex, instructIndex } } } = state
    return fnIndex === fni && instructIndex === ini
  })

  return (
    <div
      class="fn-block cursor-pointer"
      classList={{
        "border-gray-600": isSelected(),
        "border-gray-300": !isSelected()
      }}
    >
      <button onClick={toggleInstruction} class="w-full h-full">
        <InstructionSymbol
          type={instruction.type}
          condColor={instruction.condColor}
          fnIndex={instruction["fnIndex"]}
          paintColor={instruction["paintColor"]}
        />
      </button>
      <Show when={isSelected()}>
        <div class="absolute bottom-10 right-10">
          <Actions />
        </div>
      </Show>
    </div>
  )
}

export default FnInstruction
