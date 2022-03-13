use logic_game::{Level, Position, Ship, Direction, Round};

fn test_level() -> Level {
    Level {
        ship_orig: Ship {
            pos: Position { x: 3, y: 4 },
            dir: Direction::Up
        },
        funcs: vec![2],
        cells: vec![]
    }
}
fn test_round() -> Round {
    Round::new(test_level())
}

#[test]
fn correct_test_round() {
    let round = test_round();

    assert!(round.instructs.len() == 1);
    assert!(round.instructs[0].len() == 2);
}

#[test]
fn it_runs() {
    let round = test_round();
}
