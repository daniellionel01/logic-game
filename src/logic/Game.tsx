import {Component, ParentProps} from "solid-js"

const Game: Component = (props: ParentProps) => {
  return (
    <div>
      {props.children}
    </div>
  )
}

export default Game
