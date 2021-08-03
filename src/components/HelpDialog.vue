<template>
    <div id="help-dialog">
        <div id="content">
            <h1>How to play</h1>
            <p>
                <i class="fas fa-arrow-up"></i>&emsp;move forward one square
            </p>
            <p>
                <i class="fas fa-undo"></i>&emsp;turn left
            </p>
            <p>
                <i class="fas fa-redo"></i>&emsp;turn right
            </p>
            <p>
                <i class="fas fa-fill"></i>&emsp;set color of current square
            </p>
            <p>
                f0&emsp;execute instructions in f0
            </p>
            <p>
                <i id="conditional-square" class="fas fa-arrow-up"></i>
                &nbsp;move forward <b>if</b> current square is red
            </p>

            <button id="close-btn" @click="$emit('close')">
                <i class="far fa-times-circle"></i>
            </button>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
    name: "HelpDialog",
    setup() {
    },
})
</script>

<style scoped>
#help-dialog {
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

#conditional-square {
    width: 20px;
    height: 20px;
    background-color: red;
    border: 2px solid #CCC;
    color: white;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

#close-btn {
    position: absolute;
    top: 20px;
    right: 20px;

    border: none;
    background: none;
    font-size: 1.2em;
    cursor: pointer;
}
</style>