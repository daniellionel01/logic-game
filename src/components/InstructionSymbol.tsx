import {Component, Match, Switch} from "solid-js";
import {Color, InstructionType} from "../store";

export interface InstructionSymbolProps {
  type: InstructionType
  fnIndex?: number,
  paintColor?: Color,
  condColor?: Color
}

const InstructionSymbol: Component<InstructionSymbolProps> = (props: InstructionSymbolProps) => {
  const { type, fnIndex, paintColor, condColor } = props

  return (
    <div
      class="w-full h-full flex justify-center items-center"
      classList={{
        "bg-red-500": condColor === "RED",
        "bg-blue-500": condColor === "BLUE",
        "bg-green-500": condColor === "GREEN",
        "text-white": !!condColor && (condColor !== "NONE" || condColor === paintColor)
      }}
    >
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
          <span>f{fnIndex}</span>
        </Match>
        <Match when={type === InstructionType.COND_COLOR}>
        </Match>
        <Match when={type === InstructionType.PAINT_COLOR}>
          <i
            class="fas fa-fill"
            classList={{
              "text-red-500": paintColor === "RED" && condColor !== paintColor,
              "text-blue-500": paintColor === "BLUE" && condColor !== paintColor,
              "text-green-500": paintColor === "GREEN" && condColor !== paintColor
            }}
          ></i>
        </Match>
      </Switch>
    </div>
  )
}

export default InstructionSymbol
