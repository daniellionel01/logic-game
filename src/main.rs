use std::thread;
use std::time::Duration;
extern crate num_cpus;

enum Direction {
    Up, Down, Left, Right
}
enum Color {
    Red, Green, Blue, None
}
enum InstructionType {
    Pass, Forward, RotateLeft, RotateRight,
    CallFunction, Paint
}

struct Instruction {
    instruction_type: InstructionType,
    color: Color,
    payload: u32,
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

fn main() {
    let colors: Vec<Color> = vec![
        Color::None,
        Color::Red,
        Color::Green,
        Color::Blue
    ];
    let instructions: Vec<InstructionType> = vec![
        InstructionType::Pass,
        InstructionType::Forward,
        InstructionType::RotateLeft,
        InstructionType::RotateRight,
        InstructionType::CallFunction,
        InstructionType::Paint
    ];
    let permutations: Vec<Instruction> = vec![];
    for c in colors {
        for i in instructions {
            let instruction: Instruction = Instruction {
                instruction_type: i,
                color: c,
                payload: 0
            };
            permutations.push(instruction);

            if i == InstructionType::CallFunction {
                let inst: Instruction = instruction.copy
                permutations.push(instruction);
            }
        }
    }

    let mut total: i32 = 24;
    total = total.pow(10);

    // permutations array
    // total permutations

    // get count of cpu cores
    // spawn as many threads
    // each for one segment of total permutations
    // thread::spawn(|| { });

    let cpus = num_cpus::get();
    for i in 0..cpus {
        println!("{}", i);
    }

    println!("{}", total)
}
