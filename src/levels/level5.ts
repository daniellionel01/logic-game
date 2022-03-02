import { Level, Direction, Color } from "../game"

const level: Level = {
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
}
export default level
