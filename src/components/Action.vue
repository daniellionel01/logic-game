<template>
  <div id="action">
    <button @click="handleAction" :disabled="disabled">
      <ActionSymbol :instructionType="instructionType" :payload="payload" :color="color" />
    </button>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
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
    color: Number,
    disabled: {
      type: Boolean,
      default: false
    }
  },
  setup: (props) => {
    const store = useStore()

    const handleAction = () => {
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
    }

    const disabled = computed(() => {
      if (props.disabled) return true

      if (!props.payload) return false

      return props.instructionType === InstructionType.CALL_FUNCTION &&
        props.payload >= store.state.functions.length
    })

    return {
      handleAction,
      disabled
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
