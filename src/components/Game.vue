<template>
  <div id="game">
    <InfoBar />
    <Grid />
    <ExecutionBar />
    <Commands />
  </div>

  <WonDialog v-if="won" />
</template>

<script lang="ts">
import { defineComponent, watch, onMounted, computed } from 'vue'
import { useStore } from '../store'
import InfoBar from './InfoBar.vue'
import Grid from './Grid.vue'
import ExecutionBar from './ExecutionBar.vue'
import Commands from './Commands.vue'
import WonDialog from './WonDialog.vue'

export default defineComponent({
  name: 'Game',
  components: {
    InfoBar,
    Grid,
    ExecutionBar,
    Commands,
    WonDialog
  },
  setup: () => {
    const store = useStore()

    const won = computed(() => store.getters.won)

    onMounted(() => {
      store.commit("loadLevel")
      store.commit("resetLevel")
    })

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
      () => store.getters.won,
      (value, prevValue) => {
        if (!prevValue && value) { // won!
          clearInterval(interval)
        }
      }
    )
    watch(
      () => store.getters.lost,
      (value, prevValue) => {
        if (!prevValue && value) { // lost!
          clearInterval(interval)
        }
      }
    )

    watch(
      () => store.state.step,
      (value, prevValue) => {
        if (prevValue > 0 && value === 0) { // stopping
          store.commit("initStack")
        }
      }
    )

    watch(
      () => store.state.functions,
      (_value) => {
        if (store.state.step > 0) return;
        store.commit("initStack")
      },
      {
        immediate: true,
        deep: true
      }
    )

    return {
      won
    }
  }
})
</script>

<style scoped>
#game {
  display: flex;
  /*border: 2px solid black;*/
  flex-direction: column;

  padding: 3em;
}
</style>
