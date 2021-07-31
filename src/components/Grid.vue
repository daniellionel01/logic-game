<template>
  <div id="grid">
    <div id="grid-container" :style="cellStyle">
        <Cell v-for="(cell, index) in cells" :key="index" :data="cell" :index="index" class="cell" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import Cell from './Cell.vue'
import { useStore } from '../store'

export default defineComponent({
  name: 'Grid',
  components: {
    Cell
  },
  setup: () => {
    const store = useStore()

    const cellStyle = {
      'display': 'grid',
      'gridTemplateColumns': Array.from(Array(store.state.grid.cols).keys()).map(_ => "1fr").join(" "),
      'gap': '5px'
    }

    return {
      cells: store.state.grid.cells,
      cellStyle
    }
  }
})
</script>

<style scoped>
#grid {
  margin: 50px auto 50px auto;
}
.cell {
  width: 50px;
  height: 50px;
}
</style>
