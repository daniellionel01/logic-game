<template>
  <div id="exec">
    <h2>Execution</h2>
    <div id="actions">
      <div id="pipeline">
        <div class="instruction" v-for="(instruction, index) in stack" :key="index">
          <ActionSymbol :instructionType="instruction.type" :payload="instruction.payload" :color="instruction.color" />
        </div>
      </div>
      <button @click="play" :disabled="playing">play</button>
      <button @click="step" :disabled="playing">step</button>
      <button @click="stop" :disabled="!playing">pause</button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
import { useStore } from '../store'
import ActionSymbol from './ActionSymbol.vue'

export default defineComponent({
  name: 'ExecutionBar',
  components: {
    ActionSymbol
  },
  setup: () => {
    const store = useStore()

    const stack = computed(() => store.state.stack)
    const playing = computed(() => store.state.playing)

    return {
      play: () => store.commit("play"),
      stop: () => store.commit("stop"),
      step: () => store.commit("step"),

      stack,
      playing
    }
  }
})
</script>

<style scoped>
#exec {
  padding: 10px;
}
#actions {
  display: flex;
}
#pipeline {
  border: 2px solid black;
  height: 30px;
  flex-grow: 1;
  display: flex;
  align-items: center;
}
.instruction {
  width: 30px;
  height: 30px;

  display: flex;
  justify-content: center;
  align-items: center;

  border-right: 2px solid black;
  font-size: 0.75em;
}
</style>
