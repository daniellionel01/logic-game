import { Component, createMemo } from "solid-js";
import Grid from "./components/Grid"
import {LevelProvider} from "./components/Level";
import { gameStore } from "./store";

const App: Component = () => {
  const [state, _setState] = gameStore

  const level = createMemo(() => state.currentLevelIndex+1)

  return (
    <LevelProvider>
      <div class="container mx-auto mt-20">
        <h1 class="text-4xl font-bold">Logic Game</h1>
        <h2 class="text-3xl font-semibold mt-3">Level {level()}</h2>
        <div>
          <Grid />
        </div>
      </div>
    </LevelProvider>
  );
};

export default App;
