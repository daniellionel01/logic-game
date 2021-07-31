import { createStore, useStore as baseUseStore, Store } from 'vuex';
import { InjectionKey } from 'vue'

export enum Color {
    NONE,
    RED,
    GREEN,
    BLUE
}
export interface Cell {
    star: boolean
    color: Color
    collected: boolean
}
export interface Grid {
    rows: number
    cols: number
    cells: Cell[]
}

export enum Direction {
    TOP,
    RIGHT,
    BOTTOM,
    LEFT
}

export interface Ship {
    row: number
    col: number
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
    type: InstructionType,
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

export interface State {
    ship: Ship,
    grid: Grid,
    functions: Function[],
    stack: Instruction[],
    selectedInstruction: SelectedInstruction
}
export const key: InjectionKey<Store<State>> = Symbol()

export const store = createStore<State>({
    state: {
        ship: {
            row: 3,
            col: 3,
            direction: Direction.TOP
        },
        grid: {
            rows: 7,
            cols: 7,
            cells: [
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: true, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: true, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.GREEN },
                { star: false, collected: false, color: Color.RED },
                { star: true, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: true, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE },
                { star: false, collected: false, color: Color.NONE }
            ]
        },
        functions: [
            { instructions: [
                { type: InstructionType.FORWARD, color: Color.NONE, payload: undefined },
                { type: InstructionType.FORWARD, color: Color.NONE, payload: undefined },
                { type: InstructionType.ROTATE_LEFT, color: Color.NONE, payload: undefined },
                { type: InstructionType.CALL_FUNCTION, color: Color.NONE, payload: 1 }
            ]},
            { instructions: [
                { type: InstructionType.ROTATE_LEFT, color: Color.RED, payload: undefined },
                { type: InstructionType.CALL_FUNCTION, color: Color.NONE, payload: 0 }
            ]}
        ],
        stack: [],
        selectedInstruction: {
            functionIndex: 0,
            instructionIndex: 0
        }
    },
    getters: {
        getCellByRowCol: (state) => (row: number, col: number): Cell | null => {
            const cell = state.grid.cells[col + row * state.grid.cols]
            return cell || null
        },
        getRowByIndex: (state) => (index: number): number => {
            return Math.floor(index / state.grid.rows)
        },
        getColByIndex: (state) => (index: number): number => {
            return index % state.grid.cols
        },

        shipCell(state, getters): Cell | undefined {
            return state.grid.cells.find((_cell, index) => {
                const row = getters.getRowByIndex(index)
                const col = getters.getColByIndex(index)
                return state.ship.row === row && state.ship.col === col
            })
        },

        lost(_state, getters) {
            if (!getters.shipCell) return false;
            return getters.shipCell.color === Color.NONE
        },
        won(state) {
            return state.grid.cells.filter(cell => cell.star && !cell.collected).length === 0
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
        }
    }
})

export function useStore() {
    return baseUseStore(key)
}