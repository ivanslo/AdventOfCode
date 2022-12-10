use onig::Regex;
use std::fmt::Debug;
use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Vec<Instruction> = parse(contents);
    let inst = inflate(&input);
    let res_p1 = part1(&inst);
    assert!(res_p1 == 13140);
    let res_p2 = part2(&inst);
    assert!(res_p2 == 0);
}

#[derive(Debug)]
enum Instruction {
    Noop,
    Addx(i32),
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Vec<Instruction> = parse(contents);
    let inst = inflate(&input);
    let res_p1 = part1(&inst);
    println!("part 1: {res_p1} | expected 14540");
    println!("part 2: below | expected EHZFZHCZ");
    part2(&inst);
}

fn parse(filecontent: String) -> Vec<Instruction> {
    let noop = Regex::new(r"noop").unwrap();
    let addx = Regex::new(r"addx (.*)").unwrap();
    filecontent
        .lines()
        .map(|x| {
            if noop.is_match(x) {
                return Instruction::Noop;
            }
            let n = addx
                .captures(x)
                .unwrap()
                .at(1)
                .unwrap()
                .parse::<i32>()
                .unwrap();
            Instruction::Addx(n)
        })
        .collect()
}

fn inflate(instr: &[Instruction]) -> Vec<Instruction> {
    // add more instructions to the instructions vector, in order to have
    // each position of the vector representing one loop
    let mut vec: Vec<Instruction> = Vec::new();
    vec.push(Instruction::Noop); // effects take effect 1 loop later
    instr.iter().for_each(|i| match i {
        Instruction::Noop => {
            vec.push(Instruction::Noop);
        }
        Instruction::Addx(nr) => {
            // each addx instruction takes 2 loops
            vec.push(Instruction::Noop);
            vec.push(Instruction::Addx(*nr));
        }
    });
    vec
}

fn registry_over_time(instr: &[Instruction]) -> Vec<i32> {
    instr
        .iter()
        .scan(1, |x, i| match i {
            Instruction::Addx(nr) => {
                *x += *nr;
                Some(*x)
            }
            Instruction::Noop => Some(*x),
        })
        .collect()
}

fn part1(instr: &[Instruction]) -> i32 {
    let reg = registry_over_time(instr);
    [20, 60, 100, 140, 180, 220]
        .iter()
        .map(|x| reg[x - 1] * *x as i32)
        .sum::<i32>()
}
fn part2(instr: &[Instruction]) -> i32 {
    let regs = registry_over_time(instr);

    for (i, pos) in regs.iter().enumerate() {
        if i % 40 == 0 {
            println!()
        }
        let pixel = if (pos - (i % 40) as i32).abs() < 2 {
            '#'
        } else {
            '.'
        };
        print!("{pixel}");
    }
    println!();
    0
}
