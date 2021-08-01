<template>
  <div id="game">
    <div>won: {{won}}</div>
    <div>lost: {{lost}}</div>
    <Grid />
    <ExecutionBar />
    <Commands />
  </div>
</template>

<script lang="ts">
import { defineComponent, watch, computed, onMounted } from 'vue'
import { useStore } from '../store'
import Grid from './Grid.vue'
import ExecutionBar from './ExecutionBar.vue'
import Commands from './Commands.vue'

export default defineComponent({
  name: 'Game',
  components: {
    Grid,
    ExecutionBar,
    Commands
  },
  setup: () => {
    const store = useStore()

    let interval: number | undefined;
    watch(
      () => store.state.playing,
      (value, prevValue) => {
        if (prevValue && !value) { // playing => stop
          clearInterval(interval)
          store.commit("initStack")
        } else { // start playing
          interval = setInterval(() => store.commit("step"), 250)
        }
      }
    )

    watch(
      () => store.state.functions,
      (value) => {
        if (store.state.step > 0) return;
        store.commit("initStack")
      },
      {
        immediate: true,
        deep: true
      }
    )

    onMounted(() => {
      store.commit("resetLevel")
    })

    return {
      won: computed(() => store.getters.won),
      lost: computed(() => store.getters.lost)
    }
  }
})
</script>

<style scoped>
#game {
  display: flex;
  border: 2px solid black;
  flex-direction: column;

  padding: 3em;
}
</style>
