import {Component, createMemo} from "solid-js";
import {produce} from "solid-js/store";
import {gameStore, Instruction} from "../store";
import InstructionSymbol from "./InstructionSymbol";

interface FnInstructionProps {
  fni: number;
  ini: number;
  instruction: Instruction
}

const FnInstruction: Component<FnInstructionProps> = (props: FnInstructionProps) => {
  const { fni, ini, instruction } = props

  const [state, setState] = gameStore

  const selectInstruction = () => {
    setState(produce(s => {
      s.game.selectedInstruct = { fnIndex: fni, instructIndex: ini }
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
      onClick={selectInstruction}
    >
      <InstructionSymbol
        type={instruction.type}
        condColor={instruction.condColor}
        fnIndex={instruction["fnIndex"]}
        paintColor={instruction["paintColor"]}
      />
    </div>
  )
}

export default FnInstruction
