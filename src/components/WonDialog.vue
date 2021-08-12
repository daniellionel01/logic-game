<template>
    <div id="won-dialog">
        <div id="content">
            <h1>You won!</h1>

            <p>You successfully collected all stars. Good job!</p>
            
            <div id="actions">
                <button @click="gotoNextLevel">next level</button>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useStore } from '../store'

export default defineComponent({
    name: "WonDialog",
    setup() {
        const store = useStore()

        const gotoNextLevel = () => {
            store.commit("gotoNextLevel")
            store.commit("loadLevel")
            store.commit("resetLevel")
            store.commit("initStack")
        }

        return {
            gotoNextLevel
        }
    },
})
</script>

<style scoped>
#won-dialog {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    transition: opacity 0.3s ease;
}

#content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);

    width: 500px;
    margin: 0px auto;
    padding: 20px 30px;
    background-color: #fff;
    border-radius: 2px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);

    font-size: 1em;
}

#actions {
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
}
</style>