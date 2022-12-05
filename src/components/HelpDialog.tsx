import {Component} from "solid-js";

const dialogID = "help-dialog"

const HelpDialog: Component = () => {
  return (
    <div>
      <label htmlFor={dialogID} class="btn btn-primary w-full">help</label>

      <input type="checkbox" id={dialogID} class="modal-toggle" />
      <div class="modal cursor-pointer">
        <div class="modal-box relative">
          <h3 class="text-lg font-bold">How to play</h3>
          <div class="mt-4 text-lg space-y-2">
            <div class="flex space-x-4">
              <div>
                <i class="fas fa-arrow-up"></i>
              </div>
              <div>move forward one square</div>
            </div>
            <div class="flex space-x-4">
              <div>
                <i class="fas fa-undo"></i>
              </div>
              <div>turn left</div>
            </div>
            <div class="flex space-x-4">
              <div>
                <i class="fas fa-redo"></i>
              </div>
              <div>turn right</div>
            </div>
            <div class="flex space-x-4">
              <div>
                <i class="fas fa-fill"></i>
              </div>
              <div>set color of current square</div>
            </div>
            <div class="flex space-x-4">
              <div>f0</div>
              <div>execute instructions in f0</div>
            </div>
            <div class="flex space-x-4">
              <div class="w-6 h-6 aspect-square bg-red-500 text-white font-semibold flex justify-center items-center">
                <i class="fas fa-arrow-up"></i>
              </div>
              <div>move forward <b>if</b> current square is red</div>
            </div>
          </div>

          <div class="modal-action">
            <label htmlFor={dialogID} class="btn btn-primary">ok!</label>
          </div>
        </div>
      </div>
    </div>
  )
}

export default HelpDialog
