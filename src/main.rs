//use std::thread;
//use std::time::Duration;
extern crate num_cpus;

#[derive(Debug, Clone)]
enum Direction {
    Up, Down, Left, Right
}
#[derive(Debug, Clone)]
enum Color {
    Red, Green, Blue, None
}
#[derive(Debug, Clone)]
enum InstructionType {
    Pass, Forward, RotateLeft, RotateRight,
    CallFunction, Paint
}

#[derive(Debug, Clone)]
struct Instruction {
    instruction_type: InstructionType,
    color: Color,
    payload: u32,
}

#[derive(Debug, Clone)]
struct Ship {
    x: i64,
    y: i64,
    dir: Direction
}

#[derive(Debug, Clone)]
struct Cell {
    x: i64,
    y: i64,
    color: Color,
}

#[derive(Debug, Clone)]
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
    let mut permutations: Vec<Instruction> = vec![];
    for c in &colors {
        for i in &instructions {
            let instruction: Instruction = Instruction {
                instruction_type: i.clone(),
                color: c.clone(),
                payload: 0
            };
            permutations.push(instruction.clone());

            let is_call = match i {
                InstructionType::CallFunction => true,
                _ => false
            };
            if is_call {
                permutations.push(Instruction {
                    payload: 1,
                    ..instruction
                });
            }
        }
    }

    println!("{}", permutations.len());

    let mut total: usize = permutations.len();
    total = total.pow(10);
    println!("{}", total);

    for perm in &permutations {
        println!("{:?} {:?} {:?}", perm.instruction_type, perm.color, perm.payload);
    }

    let cores = num_cpus::get();
    println!("cpu cores: {}", cores);

    // get count of cpu cores
    // spawn as many threads
    // each for one segment of total permutations
    // thread::spawn(|| { });
}
