<template>
  <div :style="symbolStyle">
    <div v-if="instructionType === IT_FORWARD">
      <i class="fas fa-arrow-up"></i>
    </div>
    <div v-else-if="instructionType === IT_ROT_LEFT">
      <i class="fas fa-undo"></i>
    </div>
    <div v-else-if="instructionType === IT_ROT_RIGHT">
      <i class="fas fa-redo"></i>
    </div>
    <div v-else-if="instructionType === IT_PAINT_COLOR">
      <i class="fas fa-fill" :style="paintStyle"></i>
    </div>

    <div v-else-if="instructionType === IT_CALL_FUNC">
      <span>f{{payload}}</span>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
import { useStore, InstructionType } from '../store'

export default defineComponent({
  name: 'Action',
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

    const symbolStyle = computed(() => ({
      background: store.getters.getCSSColor(props.color),
      color: props.color ? "white" : "black",
      width: '100%',
      height: '100%',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center'
    }))

    const paintStyle = computed(() => ({
      color: props.color
        ? (props.color === props.payload ? "white" : store.getters.getCSSColor(props.payload))
        : store.getters.getCSSColor(props.payload)
    }))

    return {
      symbolStyle,
      paintStyle,

      IT_CLEAR: InstructionType.PASS,
      IT_FORWARD: InstructionType.FORWARD,
      IT_ROT_RIGHT: InstructionType.ROTATE_RIGHT,
      IT_ROT_LEFT: InstructionType.ROTATE_LEFT,
      IT_CALL_FUNC: InstructionType.CALL_FUNCTION,
      IT_PAINT_COLOR: InstructionType.PAINT_COLOR,
    }
  }
})
</script>

<style scoped>
</style>
