<template>
  <div id="commands">
    <div id="actions">
      <h2>Actions</h2>
      <div class="action-row">
        <Action :instructionType="IT_ROT_LEFT" />
        <Action :instructionType="IT_FORWARD" />
        <Action :instructionType="IT_ROT_RIGHT" />
      </div>
      <div class="action-row">
        <Action :instructionType="IT_CALL_FUNC" :payload="0" />
        <Action :instructionType="IT_CALL_FUNC" :payload="1" />
        <Action :instructionType="IT_CALL_FUNC" :payload="2" />
      </div>
      <div class="action-row">
        <Action :instructionType="IT_COND_COLOR" :color="COLOR_RED" />
        <Action :instructionType="IT_COND_COLOR" :color="COLOR_GREEN" />
        <Action :instructionType="IT_COND_COLOR" :color="COLOR_BLUE" />
      </div>
    </div>
    <div id="functions">
      <h2>Functions</h2>
      <Function v-for="(func, index) in functions" :key="index" :index="index" :data="func" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useStore, InstructionType, Color } from '../store'
import Function from './Function.vue'
import Action from './Action.vue'

export default defineComponent({
  name: 'Commands',
  components: {
    Function,
    Action
  },
  setup: () => {
    const store = useStore()

    return {
      functions: store.state.functions,
      IT_FORWARD: InstructionType.FORWARD,
      IT_ROT_RIGHT: InstructionType.ROTATE_RIGHT,
      IT_ROT_LEFT: InstructionType.ROTATE_LEFT,
      IT_CALL_FUNC: InstructionType.CALL_FUNCTION,
      IT_PAINT_COLOR: InstructionType.PAINT_COLOR,
      IT_COND_COLOR: InstructionType.COND_COLOR,

      COLOR_RED: Color.RED,
      COLOR_GREEN: Color.GREEN,
      COLOR_BLUE: Color.BLUE
    }
  }
})
</script>

<style scoped>
#commands {
  padding: 10px;
  display: flex;
}
#commands > div {
  flex-grow: 1;
}
.action-row {
  display: flex;
}
</style>
