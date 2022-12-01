import { Level } from "../store";

const level: Level = {
  ship: {
      row: 7, col: 13, dir: "LEFT"
  },
  functions: [6],
  paints: { red: false, green: false, blue: false },
  cells: [
      { row: 1, col: 1, color: "GREEN" },
      { row: 2, col: 1, color: "GREEN" },
      { row: 2, col: 2, color: "GREEN" },
      { row: 3, col: 2, color: "GREEN" },
      { row: 3, col: 3, color: "GREEN" },
      { row: 4, col: 3, color: "GREEN" },
      { row: 4, col: 4, color: "GREEN" },
      { row: 5, col: 4, color: "GREEN" },
      { row: 5, col: 5, color: "GREEN" },
      { row: 6, col: 5, color: "GREEN" },
      { row: 6, col: 6, color: "GREEN" },
      { row: 7, col: 6, color: "RED" },
      { row: 7, col: 7, color: "GREEN" },
      { row: 7, col: 8, color: "GREEN" },
      { row: 7, col: 9, color: "GREEN" },
      { row: 7, col: 10, color: "GREEN" },
      { row: 7, col: 11, color: "GREEN" },
      { row: 7, col: 12, color: "GREEN" },
      { row: 7, col: 13, color: "GREEN" },
  ],
  stars: [
      { row: 1, col: 1 }
  ]
}
export default level
