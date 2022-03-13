
#[derive(Debug, Copy, Clone)]
pub struct Position {
    pub x: u32,
    pub y: u32,
}
impl Position {
    pub fn eq(&self, other: Position) -> bool {
        self.x == other.x && self.y == other.y
    }
}

#[derive(Debug, Copy, Clone)]
pub enum Direction {
    Up, Down, Left, Right
}
#[derive(Debug, Copy, Clone)]
pub enum Color {
    Red, Green, Blue, None
}
#[derive(Debug, Copy, Clone)]
pub enum InstructionType {
    Pass, Forward, RotateLeft, RotateRight,
    CallFunction, Paint
}

#[derive(Debug, Copy, Clone)]
pub struct Instruction {
    pub instruct_type: InstructionType,
    pub paint_color: Color,
    pub call_func: u32,
}

impl Instruction {
    pub fn pass() -> Instruction {
        Instruction {
            instruct_type: InstructionType::Pass,
            paint_color: Color::None,
            call_func: 0
        }
    }
    pub fn forward() -> Instruction {
        Instruction {
            instruct_type: InstructionType::Forward,
            paint_color: Color::None,
            call_func: 0
        }
    }
    pub fn rot_left() -> Instruction {
        Instruction {
            instruct_type: InstructionType::RotateLeft,
            paint_color: Color::None,
            call_func: 0
        }
    }
    pub fn rot_right() -> Instruction {
        Instruction {
            instruct_type: InstructionType::RotateRight,
            paint_color: Color::None,
            call_func: 0
        }
    }
    pub fn paint(color: Color) -> Instruction {
        Instruction {
            instruct_type: InstructionType::Paint,
            paint_color: color,
            call_func: 0
        }
    }
    pub fn call_func(index: u32) -> Instruction {
        Instruction {
            instruct_type: InstructionType::Paint,
            paint_color: Color::None,
            call_func: index
        }
    }
}

#[derive(Debug, Copy, Clone)]
pub struct Cell {
    pos: Position,
    star: bool,
    collected: bool,
    color: Color,
}

#[derive(Debug, Copy, Clone)]
pub struct Ship {
    pub pos: Position,
    pub dir: Direction
}

#[derive(Debug, Clone)]
pub struct Level {
    pub ship_orig: Ship,
    pub funcs: Vec<u32>,
    pub cells: Vec<Cell>
}

#[derive(Debug, Clone)]
pub struct Round {
    pub ship: Ship,
    pub orig_level: Level,
    pub instructs: Vec<Vec<Instruction>>,
    pub stack: Vec<Instruction>,
    pub cells: Vec<Cell>,
    pub step: u32
}

impl Round {
    pub fn new(level: Level) -> Round {
        let mut instructs: Vec<Vec<Instruction>> = Vec::new();
        for i in level.funcs.iter() {
            let mut cur: Vec<Instruction> = Vec::new();
            for _ in 0..*i {
                cur.push(Instruction::pass())
            }
            instructs.push(cur);
        }
        Round {
            ship: level.ship_orig.clone(),
            orig_level: level.clone(),
            stack: Vec::new(),
            cells: level.cells.clone(),
            step: 0,
            instructs
        }
    }

    pub fn run(&mut self) {
        while !self.won() && !self.lost() {
            self.execute();
            self.step += 1;
        }
    }

    fn execute(&self) {
    }

    pub fn won(&self) -> bool {
        false
    }

    pub fn lost(&self) -> bool {
        true
    }

    pub fn set_instruction(&self, i: u32, j: u32, instruction: Instruction) -> &Round {
        todo!()
    }
}


