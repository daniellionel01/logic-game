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
import { defineComponent } from 'vue'
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

    return {
      won: store.getters.won,
      lost: store.getters.lost
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
