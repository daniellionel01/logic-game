import {Accessor, createContext, createMemo, ParentProps, useContext} from "solid-js";
import {gameStore, Level} from "../store";

type LevelData = [
  Accessor<Level>,
  Accessor<number>,
  Accessor<number>
]

const LevelContext = createContext<LevelData>()

export function LevelProvider(props: ParentProps) {
  const [state, _setState] = gameStore

  const level = createMemo(() => {
    return state.levels[state.currentLevelIndex]
  })
  const width = createMemo(() => {
    const cols = level().cells.map(c => c.col)
    if (cols.length === 0) return 0;
    const min = Math.min(...cols)
    const max = Math.max(...cols)
    return max - min + 1
  })
  const height = createMemo(() => {
    const rows = level().cells.map(c => c.row)
    if (rows.length === 0) return 0;
    const min = Math.min(...rows)
    const max = Math.max(...rows)
    return max - min + 1
  })

  const value: LevelData = [level, width, height]
  return (
    <LevelContext.Provider value={value}>
      {props.children}
    </LevelContext.Provider>
  )
}

export function useLevel() {
  return useContext(LevelContext)
}
