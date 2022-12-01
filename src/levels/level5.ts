import { Level } from "../store";

const level: Level = {
  ship: {
      row: 1, col: 6, dir: "BOTTOM"
  },
  functions: [6],
  paints: { red: false, green: true, blue: false },
  cells: [
      { row: 1, col: 6, color: "BLUE" },
      { row: 2, col: 6, color: "GREEN" },
      { row: 3, col: 6, color: "GREEN" },
      { row: 4, col: 6, color: "GREEN" },
      { row: 5, col: 6, color: "GREEN" },

      { row: 6, col: 1, color: "BLUE" },
      { row: 6, col: 2, color: "GREEN" },
      { row: 6, col: 3, color: "GREEN" },
      { row: 6, col: 4, color: "GREEN" },
      { row: 6, col: 5, color: "GREEN" },
      { row: 6, col: 6, color: "RED" },
      { row: 6, col: 7, color: "GREEN" },
      { row: 6, col: 8, color: "GREEN" },
      { row: 6, col: 9, color: "GREEN" },
      { row: 6, col: 10, color: "GREEN" },
      { row: 6, col: 11, color: "BLUE" },
  ],
  stars: [
      { row: 6, col: 1 },
      { row: 6, col: 11 }
  ]
}

export default level
