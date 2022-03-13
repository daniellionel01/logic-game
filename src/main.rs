extern crate num_cpus;

use logic_game::{Color, Instruction, InstructionType};

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
                instruct_type: i.clone(),
                paint_color: c.clone(),
                call_func: 0
            };
            permutations.push(instruction.clone());

            let is_call = match i {
                InstructionType::CallFunction => true,
                _ => false
            };
            if is_call {
                permutations.push(Instruction {
                    call_func: 1,
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
    let tens: Vec<usize> = vec![permutations.len()-1; 10];
    for i in 0..cores {
        let mut pems: Vec<usize> = vec![i];
        pems.extend(tens.iter().copied());
        println!("{:?}", pems);
    }
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
