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
  cells: Cell[];
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
    type: InstructionType.PASS
  }) as Instruction))
  return {
    ship: { ...level.ship },
    starsCollected: [],
    functions,
    cells: [...level.cells.map(c => ({...c}))],
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

type SetState = SetStoreFunction<GlobalStore>

export function calculateStack(setState: SetState) {
  setState(produce(s => {
    const ins = s.game.functions[0].filter(i => i.type !== InstructionType.PASS)
    s.game.stack = [...ins]
  }))
}

export function loadLevel(index: number, setState: SetState) {
  setState(produce(s => {
    if (index >= s.levels.length) {
      return;
    }

    const lvl = s.levels[index]
    s.game = getInitialGameState(lvl)
    s.currentLevelIndex = index
  }))
}

export function tick(setState: SetState) {
  setState(produce((s) => {
    s.game.step += 1

    const ship = s.game.ship;

    const nextInstruction = { ...s.game.stack[0] }
    s.game.stack.splice(0, 1)

    if (!!nextInstruction.condColor && nextInstruction.condColor !== "NONE") {
      const cell = s.game.cells.find(c => c.row === ship.row && c.col === ship.col)
      if (cell && cell.color !== nextInstruction.condColor) {
        return;
      }
    }

    if (nextInstruction.type === InstructionType.FORWARD) {
      if (ship.dir === "TOP") {
        s.game.ship = { ...ship, row: ship.row-1 }
      } else if (ship.dir === "BOTTOM") {
        s.game.ship = { ...ship, row: ship.row+1 }
      } else if (ship.dir === "LEFT") {
        s.game.ship = { ...ship, col: ship.col-1 }
      } else if (ship.dir === "RIGHT") {
        s.game.ship = { ...ship, col: ship.col+1 }
      }
    } else if (nextInstruction.type === InstructionType.ROT_L) {
      if (ship.dir === "RIGHT") {
        s.game.ship = { ...ship, dir: "TOP" }
      } else if (ship.dir === "BOTTOM") {
        s.game.ship = { ...ship, dir: "RIGHT" }
      } else if (ship.dir === "LEFT") {
        s.game.ship = { ...ship, dir: "BOTTOM" }
      } else if (ship.dir === "TOP") {
        s.game.ship = { ...ship, dir: "LEFT" }
      }
    } else if (nextInstruction.type === InstructionType.ROT_R) {
      if (ship.dir === "RIGHT") {
        s.game.ship = { ...ship, dir: "BOTTOM" }
      } else if (ship.dir === "BOTTOM") {
        s.game.ship = { ...ship, dir: "LEFT" }
      } else if (ship.dir === "LEFT") {
        s.game.ship = { ...ship, dir: "TOP" }
      } else if (ship.dir === "TOP") {
        s.game.ship = { ...ship, dir: "RIGHT" }
      }
    } else if (nextInstruction.type === InstructionType.CALL_FN) {
      const fnIns = nextInstruction as CallFnInstruction
      const instructions = s.game.functions[fnIns.fnIndex].filter(s => s.type !== InstructionType.PASS)
      s.game.stack.unshift(...instructions)
    } else if (nextInstruction.type === InstructionType.PAINT_COLOR) {
      const colorIns = nextInstruction as PaintColorInstruction

      const cell = s.game.cells.find(c => c.row === ship.row && c.col === ship.col)
      if (!cell) return;
      const index = s.game.cells.indexOf(cell)
      s.game.cells[index] = {
        ...cell,
        color: colorIns.paintColor
      }
    }
  }))
}

const lvlIndex = 0
const init: GlobalStore = {
  levels,
  currentLevelIndex: lvlIndex,
  game: getInitialGameState(levels[lvlIndex])
}

export const gameStore = createRoot(() => createLocalStore("game", init))

