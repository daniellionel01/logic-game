import { Level, Direction, Color } from "../game"

const level: Level = {
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
}
export default level
