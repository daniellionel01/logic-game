import {Component} from "solid-js";
import {useLevel} from "../context/Level";
import {gameStore} from "../store";

const ExecutionStack: Component = () => {
  const [state, _setState] = gameStore

  const { level } = useLevel()

  return (
    <div class="border-2 border-gray-700 rounded-xl w-full h-12">
      
    </div>
  )
}

export default ExecutionStack
