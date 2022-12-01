import { Level } from "../store";

const level: Level = {
  ship: {
      row: 1, col: 1, dir: "RIGHT"
  },
  functions: [2],
  paints: { red: false, green: false, blue: false },
  cells: [
      { row: 1, col: 1, color: "RED" },
      { row: 1, col: 2, color: "GREEN" },
      { row: 1, col: 3, color: "BLUE" },
      { row: 1, col: 4, color: "RED" },
      { row: 1, col: 5, color: "GREEN" },
      { row: 1, col: 6, color: "BLUE" },
      { row: 1, col: 7, color: "RED" },
  ],
  stars: [
      { row: 1, col: 7 },
  ]
}
export default level
