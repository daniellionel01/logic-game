import { Component, createMemo } from "solid-js";
import Grid from "./components/Grid"
import ExecutionStack from "./components/ExecutionStack";
import Actions from "./components/Actions";
import {LevelProvider} from "./context/Level";
import { gameStore } from "./store";
import Functions from "./components/Functions";

const App: Component = () => {
  const [state, _setState] = gameStore

  const level = createMemo(() => state.currentLevelIndex+1)

  return (
    <LevelProvider>
      <div class="container mx-auto mt-20">
        <h1 class="text-4xl font-bold">Logic Game</h1>
        <h2 class="text-3xl font-semibold mt-3">Level {level()}</h2>
        <div class="mt-8">
          <Grid />
        </div>
        <div class="mt-8">
          <ExecutionStack />
        </div>
        <div class="mt-8">
          <Actions />
        </div>
        <div class="mt-8">
          <Functions />
        </div>
      </div>
    </LevelProvider>
  );
};

export default App;
