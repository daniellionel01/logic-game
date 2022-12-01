import {Component} from "solid-js";
import {produce} from "solid-js/store";
import {useLevel} from "../context/Level";
import {gameStore, getInitialGameState} from "../store";


const WonDialog: Component = () => {
  const [state, setState] = gameStore

  const { won } = useLevel()

  const gotoNextLevel = () => {
    setState(produce((s) => {
      if (state.currentLevelIndex >= state.levels.length-1) {
        return;
      }

      const lvl = state.levels[state.currentLevelIndex+1]
      s.game = getInitialGameState(lvl)
      s.currentLevelIndex += 1
    }))
  }

  return (
    <div>
      <input type="checkbox" id="won-dialog" class="modal-toggle" checked={won()} />
      <div class="modal cursor-pointer">
        <div class="modal-box relative">
          <h3 class="text-lg font-bold">Congratulations!</h3>
          <p class="py-4">You cleared the level successfully</p>

          <div class="modal-action">
            <button class="btn" onClick={gotoNextLevel}>next level</button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default WonDialog
