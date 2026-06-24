import birdie
import game/runtime.{Position}
import gleam/list
import gleam/string

fn trim_empty_borders_content(input: String) -> String {
  let input = string.trim(input)

  let output =
    input
    |> string.split("\n")
    |> list.map(string.to_graphemes)
    |> runtime.trim_empty_borders
    |> list.map(string.join(_, ""))
    |> string.join("\n")

  "------ INPUT\n\n" <> input <> "\n\n------ OUTPUT\n\n" <> output
}

pub fn trim_empty_borders_one_border_test() {
  "
.........
.>gbrgbR.
.........
"
  |> trim_empty_borders_content
  |> birdie.snap(title: "trims empty characters with simple grid")
}

pub fn trim_empty_borders_without_empty_characters_test() {
  ">gbrgbR"
  |> trim_empty_borders_content
  |> birdie.snap(
    title: "trims empty characters with no empty characters gives back same input",
  )
}

pub fn trim_empty_borders_with_multiple_non_empty_lines_test() {
  "
.........
.>gbrgbR.
..gbrgb..
.........
"
  |> trim_empty_borders_content
  |> birdie.snap(title: "trims empty characters with multiple non-empty lines")
}

pub fn trim_empty_borders_with_non_empty_column_between_non_empty_test() {
  "
.........
.>g.rgbR.
..g.rgb..
.........
"
  |> trim_empty_borders_content
  |> birdie.snap(
    title: "trims empty characters with an empty column between non empty character columns",
  )
}

pub fn trim_empty_borders_test() {
  let cases = [
    #(
      "
.........
.>gbrgbR.
.........
",
      ">gbrgbR",
    ),
    #(
      "
.........
.>gbrgbR.
..gbrgb..
.........
",
      ">gbrgbR\n.gbrgb.",
    ),
    #(
      "
.........
.>g.rgbR.
..g.rgb..
.........
",
      ">g.rgbR\n.g.rgb.",
    ),
  ]
  list.each(cases, fn(values) {
    let #(input, output) = values
    let lines =
      input
      |> string.trim
      |> string.split("\n")
      |> list.map(string.to_graphemes)

    let result =
      lines
      |> runtime.trim_empty_borders
      |> list.map(string.join(_, ""))
      |> string.join("\n")

    assert result == output
  })
}

pub fn level_size_test() {
  assert runtime.Level(..runtime.empty_level(), cells: [
      runtime.Cell(Position(row: 1, column: 1), runtime.Red),
      runtime.Cell(Position(row: 1, column: 2), runtime.Green),
      runtime.Cell(Position(row: 1, column: 3), runtime.Blue),
      runtime.Cell(Position(row: 1, column: 4), runtime.Red),
      runtime.Cell(Position(row: 1, column: 5), runtime.Green),
      runtime.Cell(Position(row: 1, column: 6), runtime.Blue),
      runtime.Cell(Position(row: 1, column: 7), runtime.Red),
    ])
    |> runtime.level_size()
    == runtime.Size(rows: 1, columns: 7)

  assert runtime.Level(..runtime.empty_level(), cells: [
      runtime.Cell(Position(row: 1, column: 1), runtime.Red),
      runtime.Cell(Position(row: 1, column: 2), runtime.Green),
      runtime.Cell(Position(row: 1, column: 3), runtime.Blue),
      runtime.Cell(Position(row: 2, column: 3), runtime.Red),
      runtime.Cell(Position(row: 2, column: 4), runtime.Green),
      runtime.Cell(Position(row: 2, column: 5), runtime.Blue),
      runtime.Cell(Position(row: 2, column: 6), runtime.Red),
    ])
    |> runtime.level_size()
    == runtime.Size(rows: 2, columns: 6)

  assert runtime.Level(..runtime.empty_level(), cells: [
      runtime.Cell(Position(row: 2, column: 1), runtime.Red),
      runtime.Cell(Position(row: 2, column: 2), runtime.Green),
      runtime.Cell(Position(row: 2, column: 3), runtime.Blue),
      runtime.Cell(Position(row: 1, column: 3), runtime.Red),
      runtime.Cell(Position(row: 1, column: 4), runtime.Green),
      runtime.Cell(Position(row: 1, column: 5), runtime.Blue),
      runtime.Cell(Position(row: 1, column: 6), runtime.Red),
    ])
    |> runtime.level_size()
    == runtime.Size(rows: 2, columns: 6)
}

pub fn parse_level_simple_test() {
  let level =
    runtime.parse_level(
      "
P=r
f0=3
.........
.>gbrgbR.
.........
",
    )

  assert level
    == Ok(
      runtime.Level(
        player_start: runtime.Player(Position(1, 1), runtime.East),
        cells: [
          runtime.Cell(Position(row: 1, column: 1), runtime.Red),
          runtime.Cell(Position(row: 1, column: 2), runtime.Green),
          runtime.Cell(Position(row: 1, column: 3), runtime.Blue),
          runtime.Cell(Position(row: 1, column: 4), runtime.Red),
          runtime.Cell(Position(row: 1, column: 5), runtime.Green),
          runtime.Cell(Position(row: 1, column: 6), runtime.Blue),
          runtime.Cell(Position(row: 1, column: 7), runtime.Red),
        ],
        stars: [runtime.Star(Position(row: 1, column: 7))],
        functions: [runtime.FunctionSpec(runtime.FunctionId(0), 3)],
      ),
    )
}

pub fn parse_level_two_rows_test() {
  let level =
    runtime.parse_level(
      "
  P=r
  f0=3
  f1=2
  ..............
  .>r........rR.
  ..rr......rr..
  ...rr....rr...
  ....rr..rr....
  .....rrrr.....
  ......bb......
  ",
    )

  assert level
    == Ok(
      runtime.Level(
        player_start: runtime.Player(Position(1, 1), runtime.East),
        cells: [
          runtime.Cell(Position(row: 1, column: 1), runtime.Red),
          runtime.Cell(Position(row: 1, column: 2), runtime.Red),
          runtime.Cell(Position(row: 1, column: 11), runtime.Red),
          runtime.Cell(Position(row: 1, column: 12), runtime.Red),

          runtime.Cell(Position(row: 2, column: 2), runtime.Red),
          runtime.Cell(Position(row: 2, column: 3), runtime.Red),
          runtime.Cell(Position(row: 2, column: 10), runtime.Red),
          runtime.Cell(Position(row: 2, column: 11), runtime.Red),

          runtime.Cell(Position(row: 3, column: 3), runtime.Red),
          runtime.Cell(Position(row: 3, column: 4), runtime.Red),
          runtime.Cell(Position(row: 3, column: 9), runtime.Red),
          runtime.Cell(Position(row: 3, column: 10), runtime.Red),

          runtime.Cell(Position(row: 4, column: 4), runtime.Red),
          runtime.Cell(Position(row: 4, column: 5), runtime.Red),
          runtime.Cell(Position(row: 4, column: 8), runtime.Red),
          runtime.Cell(Position(row: 4, column: 9), runtime.Red),

          runtime.Cell(Position(row: 5, column: 5), runtime.Red),
          runtime.Cell(Position(row: 5, column: 6), runtime.Red),
          runtime.Cell(Position(row: 5, column: 7), runtime.Red),
          runtime.Cell(Position(row: 5, column: 8), runtime.Red),

          runtime.Cell(Position(row: 6, column: 6), runtime.Blue),
          runtime.Cell(Position(row: 6, column: 7), runtime.Blue),
        ],
        stars: [runtime.Star(Position(row: 1, column: 12))],
        functions: [
          runtime.FunctionSpec(runtime.FunctionId(0), 3),
          runtime.FunctionSpec(runtime.FunctionId(1), 2),
        ],
      ),
    )
}
