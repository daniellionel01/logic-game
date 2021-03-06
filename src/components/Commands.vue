<template>
  <div id="commands">
    <div id="actions">
      <h2>Actions</h2>
      <div class="action-row">
        <Action :instructionType="IT_PASS" />
      </div>
      <div class="action-row">
        <Action :instructionType="IT_ROT_LEFT" />
        <Action :instructionType="IT_FORWARD" />
        <Action :instructionType="IT_ROT_RIGHT" />
      </div>
      <div class="action-row" v-for="(_, index) in functionRows" :key="index">
        <Action :instructionType="IT_CALL_FUNC" :payload="index*3" />
        <Action :instructionType="IT_CALL_FUNC" :payload="index*3+1" />
        <Action :instructionType="IT_CALL_FUNC" :payload="index*3+2" />
      </div>
      <div class="action-row">
        <Action :instructionType="IT_PAINT_COLOR" :payload="COLOR_RED" :disabled="!level.paintAvailability.red" />
        <Action :instructionType="IT_PAINT_COLOR" :payload="COLOR_GREEN" :disabled="!level.paintAvailability.green" />
        <Action :instructionType="IT_PAINT_COLOR" :payload="COLOR_BLUE" :disabled="!level.paintAvailability.blue" />
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
import { defineComponent, computed } from 'vue'
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

    const functionRows = computed(() => Math.ceil(store.state.functions.length / 3))
    const level = computed(() => store.state.levels[store.state.currentLevelIndex])

    return {
      functions: computed(() => store.state.functions),
      functionRows,
      level,

      IT_PASS: InstructionType.PASS,
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
