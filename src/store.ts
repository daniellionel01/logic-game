import { createEffect, createRoot } from "solid-js";
import { createLocalStore } from "./utils"
import levels from "./levels/index"
import {produce, SetStoreFunction} from "solid-js/store";

export type Color = "NONE" | "RED" | "GREEN" | "BLUE"
export type Direction = "TOP" | "RIGHT" | "BOTTOM" | "LEFT"

export interface Position {
  row: number;
  col: number;
}
export interface Cell extends Position {
  color: Color;
}
export interface Ship extends Position {
  dir: Direction;
}

export enum InstructionType {
  PASS, FORWARD,
  ROT_R, ROT_L,
  CALL_FN, COND_COLOR, PAINT_COLOR
}

export interface DefaultInstruction {
  type: InstructionType;
  condColor: Color;
}
export interface CallFnInstruction extends DefaultInstruction {
  fnIndex: number;
}
export interface PaintColorInstruction extends DefaultInstruction {
  paintColor?: Color;
}

export type Instruction =
  | DefaultInstruction
  | CallFnInstruction
  | PaintColorInstruction

export type Function = Instruction[]

export interface SelectedInstruction {
  fnIndex: number;
  instructIndex: number;
}

export interface Star extends Position {
  collected: boolean;
}

export interface Level {
  ship: Ship;
  cells: Cell[],
  stars: Position[],
  functions: number[],
  paints: {
    red: boolean
    green: boolean
    blue: boolean
  }
}

export interface GameState {
  ship: Ship;
  starsCollected: Position[];
  functions: Function[];
  stack: Instruction[];
  selectedInstruct: SelectedInstruction;
  step: number;
  running: boolean;
}

export interface GlobalStore {
  levels: Level[];
  currentLevelIndex: number;
  game: GameState
}

export function getInitialGameState(level: Level): GameState {
  const functions = level.functions.map(n => Array.from(Array(n).keys()).map(_ => ({
    type: InstructionType.PASS,
    color: "NONE"
  }) as Instruction))
  return {
    ship: { ...level.ship },
    starsCollected: [],
    functions,
    stack: [],
    selectedInstruct: {
      fnIndex: 0,
      instructIndex: 0
    },
    step: 0,
    running: false
  }
}

export function makeEmptyCell(row: number, col: number): Cell {
  return { row, col, color: "NONE" }
}

export function calculateStack(setState: SetStoreFunction<GlobalStore>) {
  setState(produce(s => {
    s.game.stack = [...s.game.functions[0]]
  }))
}

const init: GlobalStore = {
  levels,
  currentLevelIndex: 7,
  game: getInitialGameState(levels[0])
}

export const gameStore = createRoot(() => createLocalStore("game", init))

