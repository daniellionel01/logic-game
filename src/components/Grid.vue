<template>
  <div id="grid">
    <div id="grid-container" :style="containerStyle">
      <template v-for="row in rows" :key="row">
        <template v-for="col in cols" :key="col">
          <Cell :row="row" :col="col" class="cell" />
        </template>
      </template>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
import Cell from './Cell.vue'
import { useStore } from '../store'

export default defineComponent({
  name: 'Grid',
  components: {
    Cell
  },
  setup: () => {
    const store = useStore()

    // we add +2 to width and height to have a border of empty cells around the grid
    const width = computed(() => store.getters.width + 2)
    const height = computed(() => store.getters.width + 2)

    const rows = computed(() => Array.from(Array(height.value).keys()).map((_row, index) => index))
    const cols = computed(() => Array.from(Array(width.value).keys()).map((_col, index) => index))

    const containerStyle = computed(() => ({
      'display': 'grid',
      'gridTemplateColumns': Array.from(Array(width.value).keys()).map(_ => "1fr").join(" "),
      'gap': '5px'
    }))

    const cells = computed(() => store.state.grid.cells)

    return {
      rows,
      cols,
      cells,
      containerStyle
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
