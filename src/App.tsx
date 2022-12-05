import { Component, createMemo } from "solid-js";
import Grid from "./components/Grid"
import ExecutionStack from "./components/ExecutionStack";
import {LevelProvider} from "./context/Level";
import { gameStore } from "./store";
import Functions from "./components/Functions";
import Game from "./logic/Game";
import Controls from "./components/Controls";
import WonDialog from "./components/WonDialog";
import HelpDialog from "./components/HelpDialog";
import SelectLevelDialog from "./components/SelectLevelDialog";

const App: Component = () => {
  const [state] = gameStore

  const level = createMemo(() => state.currentLevelIndex+1)

  return (
    <LevelProvider>
      <Game>
        <div class="w-full my-20 md:my-20 px-5 md:px-20">
          <div class="flex justify-between">
            <div class="w-full">
              <h1 class="text-4xl font-bold">Logic Game</h1>
              <h2 class="text-3xl font-semibold mt-3">Level {level()}</h2>
            </div>
            <div class="flex flex-col md:flex-row md:space-x-4 space-y-4 md:space-y-0">
              <HelpDialog />
              <SelectLevelDialog />
            </div>
          </div>
          <div class="mt-8 flex space-x-4">
            <ExecutionStack />
            <Controls />
          </div>
          <div class="mt-8 flex flex-col-reverse lg:flex-row justify-between">
            <div class="overflow-auto">
              <Grid />
            </div>
            <div class="flex pb-8 lg:pb-0 px-2 lg:px-8 lg:space-x-20">
              <div class="space-y-2">
                <h1 class="text-lg font-bold">Functions</h1>
                <Functions />
              </div>
            </div>
          </div>
        </div>

        <WonDialog />
      </Game>
    </LevelProvider>
  );
};

export default App;
