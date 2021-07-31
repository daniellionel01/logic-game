<template>
  <div id="game">
    <Grid />
    <ExecutionBar />
    <Commands />
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
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
  }
})
</script>

<style scoped>
#game {
  display: flex;
  border: 2px solid black;
  flex-direction: column;
}
</style>
