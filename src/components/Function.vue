<template>
  <div id="function">
    <div class="block">f{{index}}</div>
    <div v-for="(instruction, idx) in data.instructions" :key="idx" class="block"
      :class="{ 'selected': index === selectedInstruction.functionIndex && idx === selectedInstruction.instructionIndex }"
      @click="() => selectInstruction(idx)"
    >
      <ActionSymbol :instructionType="instruction.type" :payload="instruction.payload" :color="instruction.color" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { useStore, Function } from '../store'
import ActionSymbol from './ActionSymbol.vue'

export default defineComponent({
  name: 'Function',
  components: {
    ActionSymbol
  },
  props: {
    index: {
      type: Number,
      required: true
    },
    data: {
      type: Object as PropType<Function>,
      required: true
    }
  },
  setup: (props) => {
    const store = useStore()

    const selectInstruction = (instructionIndex: number) => {
      store.commit("selectInstruction", {
        functionIndex: props.index,
        instructionIndex
      })
    }

    return {
      selectedInstruction: store.state.selectedInstruction,
      selectInstruction
    }
  }
})
</script>

<style scoped>
#function {
  display: flex;
}
.block {
  width: 30px;
  height: 30px;
  border: 2px solid #CCC;
  border-radius: 8px;

  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 4px;
  margin-right: 4px;

  font-size: 0.8em;
  font-weight: 700;

  cursor: pointer;
}
.selected {
  background: lightgray;
}
</style>
