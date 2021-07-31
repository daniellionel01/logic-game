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
export interface Ship {
    row: number
    col: number
}

export interface State {
    ship: Ship,
    grid: Grid
}
export const key: InjectionKey<Store<State>> = Symbol()

export const store = createStore<State>({
    state: {
        ship: {
            row: 0,
            col: 1
        },
        grid: {
            rows: 5,
            cols: 5,
            cells: [
                { star: false, collected: false, color: Color.RED },
                { star: false, collected: false, color: Color.GREEN },
                { star: false, collected: false, color: Color.BLUE },
                { star: true, collected: false, color: Color.RED },
                { star: true, collected: false, color: Color.GREEN },
                { star: true, collected: false, color: Color.BLUE },
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
        }
    },
})

export function useStore() {
    return baseUseStore(key)
}