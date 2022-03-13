use logic_game::{Level, Position, Ship, Direction, Round};

fn test_level() -> Level {
    Level {
        ship_orig: Ship {
            pos: Position { x: 3, y: 4 },
            dir: Direction::Up
        },
        funcs: vec![5, 5],
        cells: vec![]

    }
}

fn main() {
    let level = test_level();

    let round = Round::new(level);
    println!("round: {:?}", round);
}
