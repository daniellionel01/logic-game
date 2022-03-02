import { Level, Direction, Color } from "../game"

const level: Level = {
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
}
export default level
