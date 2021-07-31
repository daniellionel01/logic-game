<template>
  <div id="cell" :style="cellStyle">
    <span id="star" v-if="data.star && !data.collected">
      <i class="fas fa-star"></i>
    </span>
    <span id="ship" v-if="isShip" :style="shipStyle">
      <i class="fas fa-space-shuttle"></i>
    </span>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, computed, watch } from 'vue'
import { useStore, Cell , Color, Direction } from '../store'

export default defineComponent({
  name: 'Cell',
  props: {
    index: {
      type: Number,
      required: true
    },
    data: {
      type: Object as PropType<Cell>,
      required: true
    }
  },
  setup: (props) => {
    const store = useStore()

    const background = computed(() => store.getters.getCSSColor(props.data.color))

    const row = computed(() => store.getters.getRowByIndex(props.index))
    const col = computed(() => store.getters.getColByIndex(props.index))
    const isShip = computed(() => store.state.ship.row === row.value && store.state.ship.col === col.value)

    watch(
      () => isShip.value,
      (value) => {
        if (!value || !props.data.star || props.data.collected) return
        store.commit("collect", props.index)
      }
    )

    const cellStyle = computed(() => ({
      "borderRadius": "8px",
      "box-shadow": "0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05)",
      ...(props.data.color ? { "background": background.value } : {}),
      ...(props.data.color === Color.NONE ? { border: "" } : {})
    }))

    const shipStyle = computed(() => ({
      "color": props.data.color === Color.NONE ? "black" : "white",
      ...(store.state.ship.direction === Direction.TOP ? { "transform": "rotate(-90deg)" } : {}),
      ...(store.state.ship.direction === Direction.RIGHT ? { "transform": "rotate(0deg)" } : {}),
      ...(store.state.ship.direction === Direction.BOTTOM ? { "transform": "rotate(90deg)" } : {}),
      ...(store.state.ship.direction === Direction.LEFT ? { "transform": "rotate(180deg)" } : {})
    }))

    return {
      cellStyle,
      isShip,
      shipStyle
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
  font-size: 1.25em;
}
#ship {
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  color: white;
  font-size: 1.25em;
}
</style>
