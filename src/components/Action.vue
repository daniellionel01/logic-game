<template>
  <div id="action">
    <button @click="handleAction">
      <ActionSymbol :instructionType="instructionType" :payload="payload" :color="color" />
    </button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useStore, InstructionType, Color } from '../store'
import ActionSymbol from './ActionSymbol.vue'

export default defineComponent({
  name: 'Action',
  components: {
    ActionSymbol
  },
  props: {
    instructionType: {
      type: Number,
      required: true
    },
    payload: Number,
    color: Number
  },
  setup: (props) => {
    const store = useStore()

    const handleAction = () => {
      if (props.instructionType !== store.getters.selectedInstruction.type) {
        if (props.color === store.getters.selectedInstruction.color) {
          store.commit("setSelectedInstructionColor", Color.NONE)
        } else if (props.instructionType === InstructionType.COND_COLOR) {
          store.commit("setSelectedInstructionColor", props.color)
        } else {
          store.commit("setSelectedInstruction", {
            type: props.instructionType,
            payload: props.payload
          })
        }
      } else {
        store.commit("setSelectedInstruction", {
          type: InstructionType.PASS
        })
      }
    }

    return {
      handleAction
    }
  }
})
</script>

<style scoped>
button {
  width: 30px;
  height: 30px;
  padding: 0;
}
</style>
