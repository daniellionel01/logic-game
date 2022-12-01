import { Level } from "../store";

const level: Level = {
  ship: {
      row: 12, col: 1, dir: "TOP"
  },
  functions: [5],
  paints: { red: false, green: false, blue: false },
  cells: [
      { row: 1, col: 1, color: "BLUE" },
      { row: 2, col: 1, color: "BLUE" },
      { row: 2, col: 2, color: "BLUE" },
      { row: 3, col: 2, color: "BLUE" },
      { row: 3, col: 3, color: "BLUE" },
      { row: 4, col: 3, color: "BLUE" },
      { row: 4, col: 4, color: "BLUE" },
      { row: 5, col: 4, color: "BLUE" },
      { row: 5, col: 5, color: "BLUE" },
      { row: 6, col: 5, color: "BLUE" },

      { row: 6, col: 6, color: "RED" },
      { row: 7, col: 6, color: "RED" },

      { row: 7, col: 5, color: "BLUE" },
      { row: 8, col: 5, color: "BLUE" },
      { row: 8, col: 4, color: "BLUE" },
      { row: 9, col: 4, color: "BLUE" },
      { row: 9, col: 3, color: "BLUE" },
      { row: 10, col: 3, color: "BLUE" },
      { row: 10, col: 2, color: "BLUE" },
      { row: 11, col: 2, color: "BLUE" },
      { row: 11, col: 1, color: "BLUE" },
      { row: 12, col: 1, color: "BLUE" },
  ],
  stars: [
      { row: 1, col: 1 },
  ]
}
export default level
