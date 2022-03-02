import { Level, Direction, Color } from "../game"

const level: Level = {
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
}
export default level
