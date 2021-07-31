<template>
  <div id="commands">
    <div id="actions">
      <h2>Actions</h2>
    </div>
    <div id="functions">
      <h2>Functions</h2>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'

export default defineComponent({
  name: 'Grid',
  setup: () => {
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
#actions {

}
#functions {

}
</style>
