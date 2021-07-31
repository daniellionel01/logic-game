<template>
  <div id="exec">
    <h2>Execution</h2>
    <div id="actions">
      <div id="pipeline">
        <span>></span>
      </div>
      <button>play</button>
      <button>step</button>
      <button>pause</button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'ExecutionBar',
  setup: () => {
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
  padding-left: 10px;
  display: flex;
  align-items: center;
}
</style>
