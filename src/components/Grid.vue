<template>
  <div id="grid">
    <div id="grid-container" :style="containerStyle">
      <template v-for="row in rows" :key="row">
        <template v-for="col in rows" :key="col">
          <Cell :row="row" :col="col" class="cell" />
        </template>
      </template>
        <!--<Cell v-for="(cell, index) in cells" :key="index" :data="cell" :index="index" class="cell" />-->
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

    const rows = computed(() => Array.from(Array(store.getters.height).keys()).map(row => row + 1))
    const cols = computed(() => Array.from(Array(store.getters.width).keys()).map(col => col + 1))

    const containerStyle = computed(() => ({
      'display': 'grid',
      'gridTemplateColumns': Array.from(Array(store.getters.width).keys()).map(_ => "1fr").join(" "),
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
