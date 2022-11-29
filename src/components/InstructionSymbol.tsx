import {Component, Match, Switch} from "solid-js";
import {Color, Instruction, InstructionPayload, InstructionType} from "../store";

export interface InstructionSymbolProps {
  type: InstructionType
  payload?: InstructionPayload
  color?: Color
}

const InstructionSymbol: Component<InstructionSymbolProps> = (props: InstructionSymbolProps) => {
  const { type, payload, color } = props

  return (
    <Switch>
      <Match when={type === InstructionType.PASS}>
      </Match>
      <Match when={type === InstructionType.FORWARD}>
        <i class="fas fa-arrow-up"></i>
      </Match>
      <Match when={type === InstructionType.ROT_R}>
        <i class="fas fa-redo"></i>
      </Match>
      <Match when={type === InstructionType.ROT_L}>
        <i class="fas fa-undo"></i>
      </Match>
      <Match when={type === InstructionType.CALL_FN}>
        <span>f{payload}</span>
      </Match>
      <Match when={type === InstructionType.COND_COLOR}>
      </Match>
      <Match when={type === InstructionType.PAINT_COLOR}>
        <i
          class="fas fa-fill"
          classList={{
            "text-red-500": color === "RED",
            "text-blue-500": color === "BLUE",
            "text-green-500": color === "GREEN"
          }}
        ></i>
      </Match>
    </Switch>
  )
}

export default InstructionSymbol
