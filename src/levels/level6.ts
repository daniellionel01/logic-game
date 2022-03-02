import { Level, Direction, Color } from "../game"

const level: Level = {
    ship: { row: 7, col: 13, direction: Direction.LEFT
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
}
export default level
