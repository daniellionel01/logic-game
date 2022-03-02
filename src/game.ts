import level1 from "./levels/level1"
import level2 from "./levels/level2"
import level3 from "./levels/level3"
import level4 from "./levels/level4"
import level5 from "./levels/level5"
import level6 from "./levels/level6"
import level7 from "./levels/level7"
import level8 from "./levels/level8"

export const enum Color {
    NONE,
    RED,
    GREEN,
    BLUE
}

export const enum Direction {
    TOP,
    RIGHT,
    BOTTOM,
    LEFT
}

export interface GridCoordinate {
    row: number,
    col: number
}

export interface Cell extends GridCoordinate {
    color: Color
}

export interface Ship extends GridCoordinate {
    direction: Direction
}

export enum InstructionType {
    PASS,
    FORWARD,

    ROTATE_RIGHT,
    ROTATE_LEFT,

    CALL_FUNCTION,
    COND_COLOR,
    PAINT_COLOR
}

export interface Instruction {
    type: InstructionType
    color: Color
    payload?: number
}

export interface Function {
    instructions: Instruction[]
}

export interface SelectedInstruction {
    functionIndex: number
    instructionIndex: number
}

export interface CellConfig extends GridCoordinate {
    color: Color,
}

export interface Star extends GridCoordinate {
    collected: boolean
}

export interface Level {
    ship: Ship
    cells: CellConfig[],
    stars: GridCoordinate[],
    functions: number[],
    paintAvailability: {
        red: boolean,
        green: boolean,
        blue: boolean
    }
}

export interface State {
    grid: {
        ship: Ship,
        cells: Cell[],
        stars: Star[]
    },
    functions: Function[],
    stack: Instruction[]
    selectedInstruction: SelectedInstruction
    step: number
    playing: boolean
    levels: Level[]
    currentLevelIndex: number
}

const state: State = {
    levels: [
        level1, level2, level3, level4,
        level5, level6, level7, level8
    ],
    currentLevelIndex: 0,
    grid: {
        ship: { row: 0, col: 0, direction: Direction.TOP },
        cells: [],
        stars: []
    },
    functions: [],
    stack: [],
    selectedInstruction: {
        functionIndex: 0,
        instructionIndex: 0
    },
    step: 0,
    playing: false
}

// === GETTERS ===
function getWidth(state: State): number {
    const cols = state.grid.cells.map(cell => cell.col)
    if (cols.length === 0) return 0

    const minCol = Math.min(...cols)
    const maxCol = Math.max(...cols)
    return maxCol - minCol + 1
}
function getHeight (state: State): number {
    const rows = state.grid.cells.map(cell => cell.row)
    if (rows.length === 0) return 0

    const minRow = Math.min(...rows)
    const maxRow = Math.max(...rows)
    return maxRow - minRow + 1
}
function getCellByRowCol(state: State, row: number, col: number): Cell | undefined {
    return state.grid.cells.find(cell => cell.row === row && cell.col === col)
}
function getShipCell(state: State): Cell | undefined {
    return state.grid.cells.find((cell) =>
        state.grid.ship.row === cell.row && state.grid.ship.col === cell.col)
}
function isLost(state: State): boolean {
    return !getShipCell(state)
}
function hasWon(state: State): boolean {
    return state.grid.stars.filter(star => !star.collected).length === 0
}
function getCSSColor (state: State, color: Color): string {
    if (color === Color.RED) return "red"
    else if (color === Color.GREEN) return "#10DB10"
    else if (color === Color.BLUE) return "#4747FF"
    return ""
}
function getSelectedInstruction(state: State): Instruction | undefined {
    return state.functions[state.selectedInstruction.functionIndex]
        .instructions[state.selectedInstruction.instructionIndex]
}

// === MUTATIONS ===
function selectInstruction(state: State, payload: SelectedInstruction) {
    Object.assign(state.selectedInstruction, {
        functionIndex: payload.functionIndex,
        instructionIndex: payload.instructionIndex
    })
}
function setSelectedInstruction(state: State, payload: Instruction) {
    const selectedInstruction =
        state.functions[state.selectedInstruction.functionIndex]
            .instructions[state.selectedInstruction.instructionIndex]

    Object.assign(selectedInstruction, {
        ...selectedInstruction,
        type: payload.type,
        ...(payload.payload !== undefined ? { payload: payload.payload } : {})
    })
}
function setSelectedInstructionColor(state: State, payload: Color) {
    const selectedInstruction =
        state.functions[state.selectedInstruction.functionIndex]
            .instructions[state.selectedInstruction.instructionIndex]
            
    Object.assign(selectedInstruction, {
        ...selectedInstruction,
        color: payload
    })
}
function loadLevel(state: State) {
    const level = state.levels[state.currentLevelIndex]

    state.step = 0
    Object.assign(state.selectedInstruction, {
        functionIndex: 0,
        instructionIndex: 0
    })
    state.functions = [...level.functions.map(num =>
        ({ instructions: Array.from(Array(num).keys()).map(() =>
            ({  type: InstructionType.PASS, color: Color.NONE, payload: undefined  })) }))]
}
function resetLevel(state: State) {
    const level = state.levels[state.currentLevelIndex]

    state.grid.cells = [...level.cells.map(cell => ({...cell}))]
    Object.assign(state.grid.stars,
        [...level.stars.map(star => ({...star, collected: false}))]
    )
    Object.assign(state.grid.ship, { ...level.ship })
}
function play(state: State) {
    state.playing = true
}
function stop(state: State) {
    state.playing = false
    state.step = 0
}
function step(state: State) {
    const instruction = state.stack.shift()
    if (!instruction) return;
    state.step += 1

    const shipCell = state.grid.cells.find(cell => cell.row === state.grid.ship.row && cell.col === state.grid.ship.col)
    if (!shipCell) return;

    if (instruction.type === InstructionType.CALL_FUNCTION) {
        if (instruction.color)
            if (shipCell.color !== instruction.color)
                return

        if (instruction.payload === undefined) return
        const func = state.functions[instruction.payload]
        const instructions = func.instructions
            .filter(instruction => instruction.type !== InstructionType.PASS)
        state.stack.unshift(...instructions)
    } else if (instruction.type === InstructionType.FORWARD) {
        if (instruction.color)
            if (shipCell.color !== instruction.color)
                return

        if (state.grid.ship.direction === Direction.TOP) {
            Object.assign(state.grid.ship, {
                ...state.grid.ship,
                row: state.grid.ship.row - 1
            })
        } else if (state.grid.ship.direction === Direction.BOTTOM) {
            Object.assign(state.grid.ship, {
                ...state.grid.ship,
                row: state.grid.ship.row + 1
            })
        } else if (state.grid.ship.direction === Direction.LEFT) {
            Object.assign(state.grid.ship, {
                ...state.grid.ship,
                col: state.grid.ship.col - 1
            })
        } else if (state.grid.ship.direction === Direction.RIGHT) {
            Object.assign(state.grid.ship, {
                ...state.grid.ship,
                col: state.grid.ship.col + 1
            })
        }
    } else if (instruction.type === InstructionType.ROTATE_LEFT) {
        if (instruction.color)
            if (shipCell.color !== instruction.color)
                return

        const direction = state.grid.ship.direction === 0 ? Direction.LEFT : (state.grid.ship.direction - 1)
        Object.assign(state.grid.ship, {
            ...state.grid.ship,
            direction
        })
    } else if (instruction.type === InstructionType.ROTATE_RIGHT) {
        if (instruction.color)
            if (shipCell.color !== instruction.color)
                return

        const direction = (state.grid.ship.direction + 1) % 4
        Object.assign(state.grid.ship, {
            ...state.grid.ship,
            direction
        })
    } else if (instruction.type === InstructionType.PAINT_COLOR) {
        if (instruction.color)
            if (shipCell.color !== instruction.color)
                return
        
        Object.assign(shipCell, {
            ...shipCell,
            color: instruction.payload
        })
    }
}
function initStack(state: State) {
    if (state.functions.length === 0) return;

    state.stack = [
        ...state.functions[0].instructions.filter(instruction => instruction.type !== InstructionType.PASS)
    ]
}
function collect(state: State, payload: GridCoordinate) {
    const star = state.grid.stars
        .find(cell => cell.row === payload.row && cell.col === payload.col)
    Object.assign(star, {
        ...star,
        collected: true
    })
}

state.currentLevelIndex = 7
loadLevel(state)

// permutate
// if ship position doesnt change for 10 rounds, continue
// if step > 1000, continue

const instructions: Instruction[] = []
for (let k = 0; k < 4; k++) { // colors
    if (k === Color.GREEN) continue;
    for (let l = 0; l < 6; l++) { // instructions
        const instruction: InstructionType = l;

        if (l === InstructionType.CALL_FUNCTION) {
            for (let m = 0; m < 2; m++) {
                instructions.push({ type: l, color: k, payload: m })
            }
        } else {
            instructions.push({ type: l, color: k, payload: undefined })
        }
    }
}

const instructionTypes = [
    "PASS",
    "FORW",
    "RO_R",
    "RO_L",
    "CALL",
    "COND"
]
const colors = [
    "NON",
    "RED",
    "",
    "BLU"
]

const total = instructions.length ** 10
let count = 0
for (let i0 = 0; i0 < instructions.length; i0++) {
    for (let i1 = 0; i1 < instructions.length; i1++) {
        for (let i2 = 0; i2 < instructions.length; i2++) {
            for (let i3 = 0; i3 < instructions.length; i3++) {
                for (let i4 = 0; i4 < instructions.length; i4++) {
                    for (let i5 = 0; i5 < instructions.length; i5++) {
                        for (let i6 = 0; i6 < instructions.length; i6++) {
                            for (let i7 = 0; i7 < instructions.length; i7++) {
                                for (let i8 = 0; i8 < instructions.length; i8++) {
                                    for (let i9 = 0; i9 < instructions.length; i9++) {
                                        resetLevel(state);

                                        [i0, i1, i2, i3, i4, i5, i6, i7, i8, i9].forEach((i, index) => {
                                            const instructionIndex = index % 5;
                                            const functionIndex = (index / 5) | 0;
                                            selectInstruction(state, { functionIndex, instructionIndex })
                                            setSelectedInstruction(state, instructions[i])
                                            setSelectedInstructionColor(state, instructions[i].color)
                                        })

                                        count += 1
                                        console.log("simulating", count, "/", total)
                                        console.log("configuration")
                                        for (let fi = 0; fi < 2; fi++) {
                                            let line = ""
                                            for (let ii = 0; ii < 5; ii++) {
                                                const instruc = state.functions[fi].instructions[ii] 
                                                const type = instructionTypes[instruc.type]
                                                const col = colors[instruc.color]
                                                line += `[${type} ${col} ${instruc.payload === undefined ? " " : instruc.payload}]`
                                            }
                                            console.log(line)
                                        }
                                        console.log()

                                        const won = round(state)
                                        stop(state)

                                        if (won) {
                                            console.log("Won")
                                            process.exit(0)
                                        } else {
                                            console.log("Lost")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// returns won
function round(state: State): boolean {
    initStack(state)
    play(state)

    let lastShipCell: Cell | undefined;
    let notMovedCount = 0;

    while(!isLost(state) && !hasWon(state)) {
        step(state)

        const shipCell = getShipCell(state)
        if (!shipCell) continue;

        if (lastShipCell) {
            if (shipCell.col === lastShipCell.col && shipCell.row === lastShipCell.row) {
                notMovedCount += 1
            } else {
                notMovedCount = 0
            }
        }
        lastShipCell = shipCell

        if (notMovedCount > 10 || state.step > 1_000) {
            return false
        }

        const star = state.grid.stars.find(star => star.row === shipCell.row && star.col === shipCell.col)
        if (!star) continue;
        if (star.collected) continue;
        collect(state, star)
    }
    return hasWon(state)
}
