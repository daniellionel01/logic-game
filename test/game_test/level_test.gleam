import birdie
import game/level
import game/level/direction
import game/level/seed
import game/position.{Position}
import gleam/list
import gleam/string

fn input_output_content(input: String, output: String) -> String {
  "------ INPUT\n" <> input <> "\n\n------ OUTPUT\n" <> output
}

fn trim_empty_borders_content(input: String) -> String {
  let input = string.trim(input)

  let output =
    input
    |> string.split("\n")
    |> list.map(string.to_graphemes)
    |> level.trim_empty_borders
    |> list.map(string.join(_, ""))
    |> string.join("\n")

  "------ INPUT\n" <> input <> "\n------ OUTPUT\n" <> output
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
      |> level.trim_empty_borders
      |> list.map(string.join(_, ""))
      |> string.join("\n")

    assert result == output
  })
}

pub fn level_size_test() {
  assert level.Level(..level.empty(), cells: [
      level.Cell(Position(row: 1, column: 1), level.Red),
      level.Cell(Position(row: 1, column: 2), level.Green),
      level.Cell(Position(row: 1, column: 3), level.Blue),
      level.Cell(Position(row: 1, column: 4), level.Red),
      level.Cell(Position(row: 1, column: 5), level.Green),
      level.Cell(Position(row: 1, column: 6), level.Blue),
      level.Cell(Position(row: 1, column: 7), level.Red),
    ])
    |> level.size()
    == level.Size(rows: 1, columns: 7)

  assert level.Level(..level.empty(), cells: [
      level.Cell(Position(row: 1, column: 1), level.Red),
      level.Cell(Position(row: 1, column: 2), level.Green),
      level.Cell(Position(row: 1, column: 3), level.Blue),
      level.Cell(Position(row: 2, column: 3), level.Red),
      level.Cell(Position(row: 2, column: 4), level.Green),
      level.Cell(Position(row: 2, column: 5), level.Blue),
      level.Cell(Position(row: 2, column: 6), level.Red),
    ])
    |> level.size()
    == level.Size(rows: 2, columns: 6)

  assert level.Level(..level.empty(), cells: [
      level.Cell(Position(row: 2, column: 1), level.Red),
      level.Cell(Position(row: 2, column: 2), level.Green),
      level.Cell(Position(row: 2, column: 3), level.Blue),
      level.Cell(Position(row: 1, column: 3), level.Red),
      level.Cell(Position(row: 1, column: 4), level.Green),
      level.Cell(Position(row: 1, column: 5), level.Blue),
      level.Cell(Position(row: 1, column: 6), level.Red),
    ])
    |> level.size()
    == level.Size(rows: 2, columns: 6)
}

pub fn parse_level_simple_test() {
  let level =
    level.parse(
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
      level.Level(
        player_start: level.Player(Position(1, 1), direction.East),
        cells: [
          level.Cell(Position(row: 1, column: 1), level.Red),
          level.Cell(Position(row: 1, column: 2), level.Green),
          level.Cell(Position(row: 1, column: 3), level.Blue),
          level.Cell(Position(row: 1, column: 4), level.Red),
          level.Cell(Position(row: 1, column: 5), level.Green),
          level.Cell(Position(row: 1, column: 6), level.Blue),
          level.Cell(Position(row: 1, column: 7), level.Red),
        ],
        stars: [level.Star(Position(row: 1, column: 7))],
        functions: [level.FunctionSpec(level.FunctionId(0), 3)],
      ),
    )
}

pub fn parse_level_two_rows_test() {
  let level =
    level.parse(
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
      level.Level(
        player_start: level.Player(Position(1, 1), direction.East),
        cells: [
          level.Cell(Position(row: 1, column: 1), level.Red),
          level.Cell(Position(row: 1, column: 2), level.Red),
          level.Cell(Position(row: 1, column: 11), level.Red),
          level.Cell(Position(row: 1, column: 12), level.Red),

          level.Cell(Position(row: 2, column: 2), level.Red),
          level.Cell(Position(row: 2, column: 3), level.Red),
          level.Cell(Position(row: 2, column: 10), level.Red),
          level.Cell(Position(row: 2, column: 11), level.Red),

          level.Cell(Position(row: 3, column: 3), level.Red),
          level.Cell(Position(row: 3, column: 4), level.Red),
          level.Cell(Position(row: 3, column: 9), level.Red),
          level.Cell(Position(row: 3, column: 10), level.Red),

          level.Cell(Position(row: 4, column: 4), level.Red),
          level.Cell(Position(row: 4, column: 5), level.Red),
          level.Cell(Position(row: 4, column: 8), level.Red),
          level.Cell(Position(row: 4, column: 9), level.Red),

          level.Cell(Position(row: 5, column: 5), level.Red),
          level.Cell(Position(row: 5, column: 6), level.Red),
          level.Cell(Position(row: 5, column: 7), level.Red),
          level.Cell(Position(row: 5, column: 8), level.Red),

          level.Cell(Position(row: 6, column: 6), level.Blue),
          level.Cell(Position(row: 6, column: 7), level.Blue),
        ],
        stars: [level.Star(Position(row: 1, column: 12))],
        functions: [
          level.FunctionSpec(level.FunctionId(0), 3),
          level.FunctionSpec(level.FunctionId(1), 2),
        ],
      ),
    )
}

pub fn parsing_level_1_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_1)
  assert level.to_string(level) == string.trim(seed.level_1)
}

pub fn parsing_level_2_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_2)
  assert level.to_string(level) == string.trim(seed.level_2)
}

pub fn parsing_level_3_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  assert level.to_string(level) == string.trim(seed.level_3)
}

pub fn parsing_level_4_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_4)
  assert level.to_string(level) == string.trim(seed.level_4)
}

pub fn parsing_level_5_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_5)
  assert level.to_string(level) == string.trim(seed.level_5)
}

pub fn parsing_level_6_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_6)
  assert level.to_string(level) == string.trim(seed.level_6)
}

pub fn parsing_level_7_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_7)
  assert level.to_string(level) == string.trim(seed.level_7)
}

pub fn parsing_level_8_and_to_string_are_equal_test() {
  let assert Ok(level) = level.parse(seed.level_8)
  assert level.to_string(level) == string.trim(seed.level_8)
}

pub fn parses_level_1_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_1)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_1), string.trim(output))
  |> birdie.snap(title: "level 1 parses correctly")
}

pub fn parses_level_2_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_2)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_2), string.trim(output))
  |> birdie.snap(title: "level 2 parses correctly")
}

pub fn parses_level_3_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_3)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_3), string.trim(output))
  |> birdie.snap(title: "level 3 parses correctly")
}

pub fn parses_level_4_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_4)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_4), string.trim(output))
  |> birdie.snap(title: "level 4 parses correctly")
}

pub fn parses_level_5_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_5)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_5), string.trim(output))
  |> birdie.snap(title: "level 5 parses correctly")
}

pub fn parses_level_6_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_6)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_6), string.trim(output))
  |> birdie.snap(title: "level 6 parses correctly")
}

pub fn parses_level_7_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_7)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_7), string.trim(output))
  |> birdie.snap(title: "level 7 parses correctly")
}

pub fn parses_level_8_correctly_test() {
  let assert Ok(level) = level.parse(seed.level_8)
  let output = level.to_string(level)

  input_output_content(string.trim(seed.level_8), string.trim(output))
  |> birdie.snap(title: "level 8 parses correctly")
}
