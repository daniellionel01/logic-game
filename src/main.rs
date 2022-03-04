use std::thread;
use std::time::Duration;
extern crate num_cpus;

enum Direction {
    UP, DOWN, LEFT, RIGHT
}
enum Color {
    RED, GREEN, BLUE, NONE
}

struct Ship {
    x: i64,
    y: i64,
    dir: Direction
}

struct Cell {
    x: i64,
    y: i64,
    color: Color,
}

struct Star {
    x: i64,
    y: i64,
    collected: bool
}

fn game() {
    let step: u32 = 0;
}

// permutations array
// total permutations

fn main() {
    // get count of cpu cores
    // spawn as many threads
    // each for one segment of total permutations
    // thread::spawn(|| { });

    let num = num_cpus::get();
    println!("{}", num);
}
