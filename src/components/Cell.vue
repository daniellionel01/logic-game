<template>
  <div id="cell" :style="cellStyle">
    <span id="ship" v-if="isShip" :style="shipStyle">
      <i class="fas fa-space-shuttle"></i>
    </span>
    <span id="star" v-if="star && !star.collected">
      <i class="fas fa-star"></i>
    </span>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed, watch } from 'vue'
import { useStore, Cell , Color, Direction } from '../store'

export default defineComponent({
  name: 'Cell',
  props: {
    row: {
      type: Number,
      required: true
    },
    col: {
      type: Number,
      required: true
    }
  },
  setup: (props) => {
    const store = useStore()

    const cell = computed(() => {
      const instore = store.state.grid.cells.find(c => c.row === props.row && c.col === props.col)
      return instore || { row: props.row, col: props.col, color: Color.NONE } as Cell
    })

    const background = computed(() => store.getters.getCSSColor(cell.value.color))

    const isShip = computed(() => store.state.grid.ship.row === props.row && store.state.grid.ship.col === props.col)
    const star = computed(() => store.state.grid.stars.find(star => star.row === props.row && star.col === props.col))

    watch(
      () => isShip.value,
      (value) => {
        if (!value || !star.value || star.value?.collected) return
        store.commit("collect", { row: props.row, col: props.col })
      }
    )

    const cellStyle = computed(() => ({
      "borderRadius": "8px",
      "box-shadow": "0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05)",
      ...(cell.value.color ? { "background": background.value } : {}),
      ...(cell.value.color === Color.NONE ? { border: "" } : {})
    }))

    const shipStyle = computed(() => ({
      "color": cell.value.color === Color.NONE ? "black" : "white",
      ...(store.state.grid.ship.direction === Direction.TOP ? { "transform": "rotate(-90deg)" } : {}),
      ...(store.state.grid.ship.direction === Direction.RIGHT ? { "transform": "rotate(0deg)" } : {}),
      ...(store.state.grid.ship.direction === Direction.BOTTOM ? { "transform": "rotate(90deg)" } : {}),
      ...(store.state.grid.ship.direction === Direction.LEFT ? { "transform": "rotate(180deg)" } : {})
    }))

    return {
      cellStyle,
      isShip,
      shipStyle,
      star
    }
  }
})
</script>

<style scoped>
#star {
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  color: white;
}
#ship {
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  color: white;
}
</style>
