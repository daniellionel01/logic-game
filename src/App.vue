<template>
  <div id="game-container">
    <Game />
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import Game from './components/Game.vue'

export default defineComponent({
  name: 'App',
  components: {
    Game
  }
})
</script>

<style>
#app {
  width: 100vw;
  height: 100vh;

  display: flex;
  justify-content: center;
  align-items: center;

  font-family: Arial, Helvetica, sans-serif;
}
#game-container {
}
h2 {
  font-size: 1em;
}
</style>
