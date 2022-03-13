
#[derive(Debug, Clone)]
pub struct Position {
    x: u32,
    y: u32,
}
impl Position {
    pub fn eq(&self, other: Position) -> bool {
        self.x == other.x && self.y == other.y
    }
}

#[derive(Debug, Clone)]
pub enum Direction {
    Up, Down, Left, Right
}
#[derive(Debug, Clone)]
pub enum Color {
    Red, Green, Blue, None
}
#[derive(Debug, Clone)]
pub enum InstructionType {
    Pass, Forward, RotateLeft, RotateRight,
    CallFunction, Paint
}

#[derive(Debug, Clone)]
pub struct Instruction {
    pub instruct_type: InstructionType,
    pub paint_color: Color,
    pub call_func: u32,
}

#[derive(Debug, Clone)]
pub struct Cell {
    pos: Position,
    star: bool,
    collected: bool,
    color: Color,
}

#[derive(Debug, Clone)]
pub struct Ship {
    pos:Position,
    dir: Direction
}

#[derive(Debug, Clone)]
pub struct Level {
    ship_orig: Ship,
    funcs: Vec<u32>,
    cells: Vec<Cell>
}

#[derive(Debug, Clone)]
pub struct Round {
    ship: Ship,
    orig_level: Level,
    instructs: Vec<Vec<Instruction>>,
    stack: Vec<Instruction>,
    cells: Vec<Cell>,
    step: u32
}

impl Round {
    pub fn run(&self) {
        self.step();
    }

    fn step(&self) {
    }
}

