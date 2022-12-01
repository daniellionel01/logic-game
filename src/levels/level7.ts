import { Level } from "../store";

const level: Level = {
  ship: {
      row: 3, col: 3, dir: "TOP"
  },
  functions: [4, 2],
  paints: { red: false, green: false, blue: false },
  cells: [
      { row: 1, col: 3, color: "RED" },
      { row: 2, col: 3, color: "RED" },
      { row: 3, col: 1, color: "RED" },
      { row: 3, col: 2, color: "RED" },
      { row: 3, col: 3, color: "GREEN" },
      { row: 3, col: 4, color: "RED" },
      { row: 3, col: 5, color: "RED" },
      { row: 4, col: 3, color: "RED" },
      { row: 5, col: 3, color: "RED" }
  ],
  stars: [
      { row: 1, col: 3 },
      { row: 3, col: 5 },
      { row: 3, col: 1 },
      { row: 5, col: 3 }
  ]
}
export default level
