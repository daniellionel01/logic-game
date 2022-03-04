<template>
  <div id="grid">
    <div id="grid-container" :style="containerStyle">
      <template v-for="row in rows" :key="row">
        <template v-for="col in cols" :key="col">
          <Cell :row="row" :col="col" class="cell" :style="cellStyle" />
        </template>
      </template>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
import Cell from './Cell.vue'
import { useStore } from '../store'
import { useWindowSize } from 'vue-window-size';

export default defineComponent({
  name: 'Grid',
  components: {
    Cell
  },
  setup: () => {
    const { width: windowWidth, height: windowHeight } = useWindowSize();

    const store = useStore()

    // we add +2 to width and height to have a border of empty cells around the grid
    const width = computed(() => store.getters.width + 2)
    const height = computed(() => store.getters.height + 2)

    const rows = computed(() => Array.from(Array(height.value).keys()).map((_row, index) => index))
    const cols = computed(() => Array.from(Array(width.value).keys()).map((_col, index) => index))

    const containerStyle = computed(() => ({
      'display': 'grid',
      'gridTemplateColumns': Array.from(Array(width.value).keys()).map(_ => "1fr").join(" "),
      'gap': '5px'
    }))

    const cellSize = computed(() => {
      const gridWidth =  width.value * 50;
      if (gridWidth <= windowWidth.value) {
        return 50
      }
      return windowWidth.value / width.value - 10
    })
    const fontSize = computed(() => {
      const gridWidth =  width.value * 50;
      if (gridWidth <= windowWidth.value) {
        return "1.25em"
      }
      return "0.75rem"
    })
    const cellStyle = computed(() => ({
      width: cellSize.value + "px",
      height: cellSize.value + "px",
      fontSize: fontSize.value
    }))

    const cells = computed(() => store.state.grid.cells)

    return {
      rows,
      cols,
      cells,
      containerStyle,
      cellStyle
    }
  }
})
</script>

<style scoped>
#grid {
  margin: 50px auto 50px auto;
}
</style>
