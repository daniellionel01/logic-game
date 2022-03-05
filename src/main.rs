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

    let cores = num_cpus::get();
    println!("cpu cores: {}", cores);

    let x: Vec<usize> = vec![permutations.len(); 10];
    nested(x, |items| {
        println!("{:?}", items);
    });

    // thread::spawn(|| { });
    // for _ in 0..cores { }
}

fn nested(n: Vec<usize>, cb: fn(Vec<usize>)) {
    nested_rec(n, cb, vec![])
}
fn nested_rec(mut n: Vec<usize>, cb: fn(Vec<usize>), items: Vec<usize>) {
    if let Some(i) = n.pop() {
        for j in 0..i {
            let mut items2: Vec<usize> = Vec::new();
            items2.extend(items.iter().copied());
            items2.push(j);

            let mut n_new: Vec<usize> = Vec::new();
            n_new.extend(n.iter().copied());

            nested_rec(n_new, cb, items2);
        }
    } else {
        cb(items);
    }
}
