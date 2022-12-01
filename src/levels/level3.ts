import { Level } from "../store";

const level: Level = {
  ship: {
      row: 1, col: 1, dir: "RIGHT"
  },
  functions: [5],
  paints: { red: false, green: false, blue: false },
  cells: [
      { row: 1, col: 1, color: "RED" },
      { row: 1, col: 2, color: "RED" },
      { row: 2, col: 2, color: "RED" },
      { row: 2, col: 3, color: "RED" },
      { row: 3, col: 3, color: "RED" },
      { row: 3, col: 4, color: "RED" },
      { row: 4, col: 4, color: "RED" },
      { row: 4, col: 5, color: "RED" },
      { row: 5, col: 5, color: "RED" },
      { row: 5, col: 6, color: "RED" },
      { row: 6, col: 6, color: "BLUE" },
      { row: 6, col: 7, color: "BLUE" },
      { row: 5, col: 7, color: "RED" },
      { row: 5, col: 8, color: "RED" },
      { row: 4, col: 8, color: "RED" },
      { row: 4, col: 9, color: "RED" },
      { row: 3, col: 9, color: "RED" },
      { row: 3, col: 10, color: "RED" },
      { row: 2, col: 10, color: "RED" },
      { row: 2, col: 11, color: "RED" },
      { row: 1, col: 11, color: "RED" },
      { row: 1, col: 12, color: "RED" },
  ],
  stars: [
      { row: 1, col: 12 },
  ]
}
export default level
