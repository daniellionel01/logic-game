<template>
  <div id="cell" :style="cellStyle">
    <span id="star" v-if="data.star">
      <i class="fas fa-star"></i>
    </span>
    <span id="ship" v-if="isShip" :style="shipStyle">
      <i class="fas fa-space-shuttle"></i>
    </span>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, computed } from 'vue'
import { useStore, Cell , Color } from '../store'

const colormap = ["red", "#10DB10", "#4747FF"]

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

    const background = computed(() => colormap[props.data.color-1])

    const row = store.getters.getRowByIndex(props.index)
    const col = store.getters.getColByIndex(props.index)
    const isShip = store.state.ship.row === row && store.state.ship.col === col

    const cellStyle = {
      "borderRadius": "8px",
      "box-shadow": "0 0 8px 0 rgba(0, 0, 0, 0.08), 0 0 20px 0 rgba(0, 0, 0, 0.05)",
      ...(props.data.color ? { "background": background.value } : {}),
      ...(props.data.color === Color.NONE ? { border: "" } : {})
    }

    const shipStyle = {
      "color": props.data.color === Color.NONE ? "black" : "white"
    }

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
