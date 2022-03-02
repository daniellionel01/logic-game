import { Level, Direction, Color } from "../game"

const level: Level = {
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
}
export default level
