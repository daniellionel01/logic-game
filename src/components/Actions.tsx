import {Component, createMemo, For} from "solid-js";
import {useLevel} from "../context/Level";
import {InstructionType} from "../store";
import {makeArray} from "../utils";
import InstructionSymbol from "./InstructionSymbol";

const Actions: Component = () => {

  const { level } = useLevel()

  const fnRows = createMemo(() => {
    const n = Math.ceil(level().functions.length / 3)
    return makeArray(n)
  })

  const setCurrentInstruction = () => {
  }

  return (
    <div>
      <div class="action-row">
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.PASS} />
        </button>
      </div>
      <div class="action-row">
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.ROT_L} />
        </button>
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.FORWARD} />
        </button>
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.ROT_R} />
        </button>
      </div>
      <For each={fnRows()}>
        {i => (
          <div>
            <button class="action-btn" disabled={i*3+1 > level().functions.length}>
              <InstructionSymbol type={InstructionType.CALL_FN} payload={i*3} />
            </button>
            <button class="action-btn" disabled={i*3+2 > level().functions.length}>
              <InstructionSymbol type={InstructionType.CALL_FN} payload={i*3+1} />
            </button>
            <button class="action-btn" disabled={i*3+3 > level().functions.length}>
              <InstructionSymbol type={InstructionType.CALL_FN} payload={i*3+2} />
            </button>
          </div>
        )}
      </For>
      <div class="action-row">
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.PAINT_COLOR} color="RED" />
        </button>
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.PAINT_COLOR} color="BLUE" />
        </button>
        <button class="action-btn">
          <InstructionSymbol type={InstructionType.PAINT_COLOR} color="GREEN" />
        </button>
      </div>
      <div class="action-row">
        <button class="action-btn bg-red-500">
          <InstructionSymbol type={InstructionType.COND_COLOR} />
        </button>
        <button class="action-btn bg-blue-500">
          <InstructionSymbol type={InstructionType.COND_COLOR} />
        </button>
        <button class="action-btn bg-green-500">
          <InstructionSymbol type={InstructionType.COND_COLOR} />
        </button>
      </div>
      <div class="action-row">
      </div>
    </div>
  )
}

export default Actions
