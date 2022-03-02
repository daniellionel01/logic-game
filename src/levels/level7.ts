import { Level, Direction, Color } from "../game"

const level: Level = {
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
}
export default level
