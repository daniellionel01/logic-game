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
import { defineComponent, watch, computed } from 'vue'
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

    watch(
      () => store.state.playing,
      (value, prevValue) => {
        console.log(value, prevValue)
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
