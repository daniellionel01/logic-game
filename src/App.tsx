import { Component, createMemo } from "solid-js";
import Grid from "./components/Grid"
import ExecutionStack from "./components/ExecutionStack";
import Actions from "./components/Actions";
import {LevelProvider} from "./context/Level";
import { gameStore } from "./store";
import Functions from "./components/Functions";
import Game from "./logic/Game";
import Controls from "./components/Controls";

const App: Component = () => {
  const [state] = gameStore

  const level = createMemo(() => state.currentLevelIndex+1)

  return (
    <LevelProvider>
      <Game>
        <div class="container mx-auto mt-20">
          <h1 class="text-4xl font-bold">Logic Game</h1>
          <h2 class="text-3xl font-semibold mt-3">Level {level()}</h2>
          <div class="mt-8">
            <Grid />
          </div>
          <div class="mt-8 flex space-x-2">
            <ExecutionStack />
            <Controls />
          </div>
          <div class="mt-8 flex justify-between">
            <Actions />
            <Functions />
          </div>
        </div>
      </Game>
    </LevelProvider>
  );
};

export default App;
