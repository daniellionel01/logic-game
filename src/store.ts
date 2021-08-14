import { createStore, useStore as baseUseStore, Store } from 'vuex';
import { InjectionKey } from 'vue'

export enum Color {
    NONE,
    RED,
    GREEN,
    BLUE
}

export enum Direction {
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
    levels: Level[]
    currentLevelIndex: number,
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
}
export const key: InjectionKey<Store<State>> = Symbol()

export const store = createStore<State>({
    state: {
        levels: [
            {
                ship: {
                    row: 1, col: 1, direction: Direction.RIGHT
                },
                functions: [2],
                paintAvailability: { red: false, green: false, blue: false },
                cells: [
                    { row: 1, col: 1, color: Color.RED },
                    { row: 1, col: 2, color: Color.GREEN },
                    { row: 1, col: 3, color: Color.BLUE },
                    { row: 1, col: 4, color: Color.RED },
                    { row: 1, col: 5, color: Color.GREEN },
                    { row: 1, col: 6, color: Color.BLUE },
                    { row: 1, col: 7, color: Color.RED },
                ],
                stars: [
                    { row: 1, col: 7 },
                ]
            },

            {
                ship: {
                    row: 9, col: 1, direction: Direction.RIGHT
                },
                functions: [5],
                paintAvailability: { red: false, green: false, blue: false },
                cells: [
                    { row: 9, col: 1, color: Color.RED },
                    { row: 9, col: 2, color: Color.RED },
                    { row: 8, col: 2, color: Color.RED },
                    { row: 8, col: 3, color: Color.RED },
                    { row: 7, col: 3, color: Color.RED },
                    { row: 7, col: 4, color: Color.RED },
                    { row: 6, col: 4, color: Color.RED },
                    { row: 6, col: 5, color: Color.RED },
                    { row: 5, col: 5, color: Color.RED },
                    { row: 5, col: 6, color: Color.RED },
                    { row: 4, col: 6, color: Color.RED },
                    { row: 4, col: 7, color: Color.RED },
                    { row: 3, col: 7, color: Color.RED },
                    { row: 3, col: 8, color: Color.RED },
                    { row: 2, col: 8, color: Color.RED },
                    { row: 2, col: 9, color: Color.RED },
                    { row: 1, col: 9, color: Color.RED },
                    { row: 1, col: 10, color: Color.RED },
                ],
                stars: [
                    { row: 1, col: 10 },
                ]
            },

            {
                ship: {
                    row: 1, col: 1, direction: Direction.RIGHT
                },
                functions: [5],
                paintAvailability: { red: false, green: false, blue: false },
                cells: [
                    { row: 1, col: 1, color: Color.RED },
                    { row: 1, col: 2, color: Color.RED },
                    { row: 2, col: 2, color: Color.RED },
                    { row: 2, col: 3, color: Color.RED },
                    { row: 3, col: 3, color: Color.RED },
                    { row: 3, col: 4, color: Color.RED },
                    { row: 4, col: 4, color: Color.RED },
                    { row: 4, col: 5, color: Color.RED },
                    { row: 5, col: 5, color: Color.RED },
                    { row: 5, col: 6, color: Color.RED },
                    { row: 6, col: 6, color: Color.BLUE },
                    { row: 6, col: 7, color: Color.BLUE },
                    { row: 5, col: 7, color: Color.RED },
                    { row: 5, col: 8, color: Color.RED },
                    { row: 4, col: 8, color: Color.RED },
                    { row: 4, col: 9, color: Color.RED },
                    { row: 3, col: 9, color: Color.RED },
                    { row: 3, col: 10, color: Color.RED },
                    { row: 2, col: 10, color: Color.RED },
                    { row: 2, col: 11, color: Color.RED },
                    { row: 1, col: 11, color: Color.RED },
                    { row: 1, col: 12, color: Color.RED },
                ],
                stars: [
                    { row: 1, col: 12 },
                ]
            },

            {
                ship: {
                    row: 12, col: 1, direction: Direction.TOP
                },
                functions: [5],
                paintAvailability: { red: false, green: false, blue: false },
                cells: [
                    { row: 1, col: 1, color: Color.BLUE },
                    { row: 2, col: 1, color: Color.BLUE },
                    { row: 2, col: 2, color: Color.BLUE },
                    { row: 3, col: 2, color: Color.BLUE },
                    { row: 3, col: 3, color: Color.BLUE },
                    { row: 4, col: 3, color: Color.BLUE },
                    { row: 4, col: 4, color: Color.BLUE },
                    { row: 5, col: 4, color: Color.BLUE },
                    { row: 5, col: 5, color: Color.BLUE },
                    { row: 6, col: 5, color: Color.BLUE },

                    { row: 6, col: 6, color: Color.RED },
                    { row: 7, col: 6, color: Color.RED },

                    { row: 7, col: 5, color: Color.BLUE },
                    { row: 8, col: 5, color: Color.BLUE },
                    { row: 8, col: 4, color: Color.BLUE },
                    { row: 9, col: 4, color: Color.BLUE },
                    { row: 9, col: 3, color: Color.BLUE },
                    { row: 10, col: 3, color: Color.BLUE },
                    { row: 10, col: 2, color: Color.BLUE },
                    { row: 11, col: 2, color: Color.BLUE },
                    { row: 11, col: 1, color: Color.BLUE },
                    { row: 12, col: 1, color: Color.BLUE },
                ],
                stars: [
                    { row: 1, col: 1 },
                ]
            },

            {
                ship: {
                    row: 1, col: 6, direction: Direction.BOTTOM
                },
                functions: [6],
                paintAvailability: { red: false, green: true, blue: false },
                cells: [
                    { row: 1, col: 6, color: Color.BLUE },
                    { row: 2, col: 6, color: Color.GREEN },
                    { row: 3, col: 6, color: Color.GREEN },
                    { row: 4, col: 6, color: Color.GREEN },
                    { row: 5, col: 6, color: Color.GREEN },

                    { row: 6, col: 1, color: Color.BLUE },
                    { row: 6, col: 2, color: Color.GREEN },
                    { row: 6, col: 3, color: Color.GREEN },
                    { row: 6, col: 4, color: Color.GREEN },
                    { row: 6, col: 5, color: Color.GREEN },
                    { row: 6, col: 6, color: Color.RED },
                    { row: 6, col: 7, color: Color.GREEN },
                    { row: 6, col: 8, color: Color.GREEN },
                    { row: 6, col: 9, color: Color.GREEN },
                    { row: 6, col: 10, color: Color.GREEN },
                    { row: 6, col: 11, color: Color.BLUE },
                ],
                stars: [
                    { row: 6, col: 1 },
                    { row: 6, col: 11 }
                ]
            },

            {
                ship: {
                    row: 7, col: 13, direction: Direction.LEFT
                },
                functions: [6],
                paintAvailability: { red: false, green: false, blue: false },
                cells: [
                    { row: 1, col: 1, color: Color.GREEN },
                    { row: 2, col: 1, color: Color.GREEN },
                    { row: 2, col: 2, color: Color.GREEN },
                    { row: 3, col: 2, color: Color.GREEN },
                    { row: 3, col: 3, color: Color.GREEN },
                    { row: 4, col: 3, color: Color.GREEN },
                    { row: 4, col: 4, color: Color.GREEN },
                    { row: 5, col: 4, color: Color.GREEN },
                    { row: 5, col: 5, color: Color.GREEN },
                    { row: 6, col: 5, color: Color.GREEN },
                    { row: 6, col: 6, color: Color.GREEN },
                    { row: 7, col: 6, color: Color.RED },
                    { row: 7, col: 7, color: Color.GREEN },
                    { row: 7, col: 8, color: Color.GREEN },
                    { row: 7, col: 9, color: Color.GREEN },
                    { row: 7, col: 10, color: Color.GREEN },
                    { row: 7, col: 11, color: Color.GREEN },
                    { row: 7, col: 12, color: Color.GREEN },
                    { row: 7, col: 13, color: Color.GREEN },
                ],
                stars: [
                    { row: 1, col: 1 }
                ]
            },

            {
                ship: {
                    row: 3, col: 3, direction: Direction.TOP
                },
                functions: [4, 2],
                paintAvailability: { red: false, green: false, blue: false },
                cells: [
                    { row: 1, col: 3, color: Color.RED },
                    { row: 2, col: 3, color: Color.RED },
                    { row: 3, col: 1, color: Color.RED },
                    { row: 3, col: 2, color: Color.RED },
                    { row: 3, col: 3, color: Color.GREEN },
                    { row: 3, col: 4, color: Color.RED },
                    { row: 3, col: 5, color: Color.RED },
                    { row: 4, col: 3, color: Color.RED },
                    { row: 5, col: 3, color: Color.RED }
                ],
                stars: [
                    { row: 1, col: 3 },
                    { row: 3, col: 5 },
                    { row: 3, col: 1 },
                    { row: 5, col: 3 }
                ]
            },
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
    },
    getters: {
        width (state) {
            const cols = state.grid.cells.map(cell => cell.col)
            if (cols.length === 0) return 0

            const minCol = Math.min(...cols)
            const maxCol = Math.max(...cols)
            return maxCol - minCol + 1
        },
        height (state) {
            const rows = state.grid.cells.map(cell => cell.row)
            if (rows.length === 0) return 0

            const minRow = Math.min(...rows)
            const maxRow = Math.max(...rows)
            return maxRow - minRow + 1
        },

        getCellByRowCol: (state) => (row: number, col: number): Cell | undefined =>
            state.grid.cells.find(cell => cell.row === row && cell.col === col),

        shipCell(state): Cell | undefined {
            return state.grid.cells.find((cell) => {
                return state.grid.ship.row === cell.row && state.grid.ship.col === cell.col
            })
        },

        lost(_state, getters) {
            return !getters.shipCell
        },
        won(state) {
            return state.grid.stars.filter(star => !star.collected).length === 0
        },

        getCSSColor: (_state) => (color: Color): string => {
            if (color === Color.RED) return "red"
            else if (color === Color.GREEN) return "#10DB10"
            else if (color === Color.BLUE) return "#4747FF"
            return ""
        },

        selectedInstruction(state) {
            return state.functions[state.selectedInstruction.functionIndex]
                .instructions[state.selectedInstruction.instructionIndex]
        }
    },
    mutations: {
        selectInstruction(state, payload: SelectedInstruction) {
            Object.assign(state.selectedInstruction, {
                functionIndex: payload.functionIndex,
                instructionIndex: payload.instructionIndex
            })
        },
        setSelectedInstruction(state, payload: { type: InstructionType, payload: number | undefined, color: Color | undefined }) {
            const selectedInstruction =
                state.functions[state.selectedInstruction.functionIndex]
                    .instructions[state.selectedInstruction.instructionIndex]

            Object.assign(selectedInstruction, {
                ...selectedInstruction,
                type: payload.type,
                ...(payload.payload !== undefined ? { payload: payload.payload } : {})
            })
        },
        setSelectedInstructionColor(state, payload: Color) {
            const selectedInstruction =
                state.functions[state.selectedInstruction.functionIndex]
                    .instructions[state.selectedInstruction.instructionIndex]
                    
            Object.assign(selectedInstruction, {
                ...selectedInstruction,
                color: payload
            })
        },
        loadLevel(state) {
            const level = state.levels[state.currentLevelIndex]

            state.step = 0
            Object.assign(state.selectedInstruction, {
                functionIndex: 0,
                instructionIndex: 0
            })
            state.functions = [...level.functions.map(num =>
                ({ instructions: Array.from(Array(num).keys()).map(() =>
                    ({  type: InstructionType.PASS, color: Color.NONE, payload: undefined  })) }))]
        },
        resetLevel(state) {
            const level = state.levels[state.currentLevelIndex]

            state.grid.cells = [...level.cells.map(cell => ({...cell}))]
            Object.assign(state.grid.stars,
                [...level.stars.map(star => ({...star, collected: false}))]
            )
            Object.assign(state.grid.ship, { ...level.ship })
        },
        play(state) {
            state.playing = true
        },
        stop(state) {
            state.playing = false
            state.step = 0
        },
        step(state) {
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
        },
        initStack(state) {
            if (state.functions.length === 0) return;

            state.stack = [
                ...state.functions[0].instructions.filter(instruction => instruction.type !== InstructionType.PASS)
            ]
        },
        collect(state, payload: GridCoordinate) {
            const star = state.grid.stars
                .find(cell => cell.row === payload.row && cell.col === payload.col)
            Object.assign(star, {
                ...star,
                collected: true
            })
        },

        gotoNextLevel(state) {
            if (state.currentLevelIndex > state.levels.length - 1) return
            state.currentLevelIndex += 1
        }
    }
})

export function useStore() {
    return baseUseStore(key)
}