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

export interface State {
    ship: Ship,
    grid: Grid,
    functions: Function[],
    stack: Instruction[]
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
                { type: InstructionType.PASS, color: Color.NONE, payload: undefined },
                { type: InstructionType.PASS, color: Color.NONE, payload: undefined },
                { type: InstructionType.PASS, color: Color.NONE, payload: undefined },
                { type: InstructionType.PASS, color: Color.NONE, payload: undefined }
            ]},
            { instructions: [
                { type: InstructionType.PASS, color: Color.NONE, payload: undefined },
                { type: InstructionType.PASS, color: Color.NONE, payload: undefined }
            ]}
        ],
        stack: []
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
        }
    },
})

export function useStore() {
    return baseUseStore(key)
}