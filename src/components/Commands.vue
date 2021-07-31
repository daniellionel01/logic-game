<template>
  <div id="commands">
    <div id="actions">
      <h2>Actions</h2>
    </div>
    <div id="functions">
      <h2>Functions</h2>
      <Function v-for="(func, index) in functions" :key="index" :index="index" :data="func" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'
import { useStore } from '../store'
import Function from './Function.vue'

export default defineComponent({
  name: 'Commands',
  components: {
    Function
  },
  setup: () => {
    const store = useStore()

    return {
      functions: store.state.functions
    }
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
