<template>
  <div id="exec">
    <h2>Execution</h2>
    <div id="actions">
      <div id="pipeline">
        <div class="instruction" v-for="(instruction, index) in stack" :key="index">
          <ActionSymbol :instructionType="instruction.type" :payload="instruction.payload" :color="instruction.color" />
        </div>
      </div>
      <button @click="play" :disabled="currentStep > 0 || lost">play</button>
      <button @click="step" :disabled="playing || lost">step</button>
      <button @click="stop" :disabled="currentStep === 0">pause</button>
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
    const currentStep = computed(() => store.state.step)
    const lost = computed(() => store.getters.lost)

    const play = () => {
      store.commit("play")
    }
    const stop = () => {
      store.commit("stop")
      store.commit("resetLevel")
    }
    const step = () => store.commit("step")

    return {
      play,
      stop,
      step,
      currentStep,
      stack,
      playing,
      lost
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
