import {Component, For} from "solid-js";
import {gameStore, loadLevel} from "../store";

const dialogID = "select-level-dialog"

const SelectLevelDialog: Component = () => {
  const [state, setState] = gameStore

  const selectLevel = (index: number) => {
    loadLevel(index, setState)
  }

  return (
    <div>
      <label htmlFor={dialogID} class="btn btn-accent w-full">select level</label>

      <input type="checkbox" id={dialogID} class="modal-toggle" />
      <div class="modal cursor-pointer">
        <div class="modal-box relative">
          <h3 class="text-lg font-bold">Select Level</h3>
          <ul class="mt-4 text-lg menu bg-base-100 w-full">
            <For each={state.levels}>
              {(_, index) => (
                <li
                  classList={{ "bordered": state.currentLevelIndex === index() }}
                  onClick={() => selectLevel(index())}
                >
                  <a>Level {index() + 1}</a>
                </li>
              )}
            </For>
          </ul>

          <div class="modal-action">
            <label htmlFor={dialogID} class="btn btn-primary">ok!</label>
          </div>
        </div>
      </div>
    </div>
  )
}

export default SelectLevelDialog
