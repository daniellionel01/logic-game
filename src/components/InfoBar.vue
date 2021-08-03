<template>
  <div id="info-bar">
    <div id="stats">
      <div>won: {{won}}</div>
      <div>lost: {{lost}}</div>
    </div>
    <div id="buttons">
      <button @click="onHelp">help</button>
    </div>
  </div>
  <HelpDialog v-if="help" @close="closeHelp" />
</template>

<script lang="ts">
import { defineComponent, computed, ref } from 'vue'
import { useStore } from '../store'
import HelpDialog from './HelpDialog.vue'

export default defineComponent({
  name: 'InfoBar',
  components: {
    HelpDialog
  },
  setup: () => {
    const store = useStore()

    const help = ref(true)
    const onHelp = () => help.value = true
    const closeHelp = () => help.value = false

    return {
      won: computed(() => store.getters.won),
      lost: computed(() => store.getters.lost),
      help, 
      onHelp,
      closeHelp
    }
  }
})
</script>

<style scoped>
#info-bar {
  display: flex;
}
#stats {
  flex-grow: 1;
  display: flex;
}
#stats > div {
  margin: 0.5em;
}
button {
  height: 100%;
}
</style>
