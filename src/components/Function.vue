<template>
  <div id="function">
    <div class="block">f{{index}}</div>
    <div v-for="(instruction, idx) in data.instructions" :key="idx" class="block">

    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { useStore, Function } from '../store'

export default defineComponent({
  name: 'Function',
  props: {
    index: {
      type: Number,
      required: true
    },
    data: {
      type: Object as PropType<Function>,
      required: true
    }
  },
  setup: (props) => {
    const store = useStore()

    return {
    }
  }
})
</script>

<style scoped>
#function {
  display: flex;
}
.block {
  width: 30px;
  height: 30px;
  border: 2px solid #CCC;
  border-radius: 8px;

  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 4px;
  margin-right: 4px;

  font-size: 0.8em;
  font-weight: 700;
}
</style>
