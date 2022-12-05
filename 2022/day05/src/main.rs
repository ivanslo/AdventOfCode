use onig::{Captures, Regex};
use std::fmt::Debug;
use std::fs;
use std::str::FromStr;

#[test]
fn test() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Input = parse(&contents);
    let res_p1 = part1(input.clone());
    let res_p2 = part2(input);
    assert!(res_p1 == "CMZ");
    assert!(res_p2 == "MCD");
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Input = parse(&contents);
    let res_p1 = part1(input.clone());
    let res_p2 = part2(input);
    println!("part 1: {res_p1} | should be QNHWJVJZW");
    println!("part 2: {res_p2} | should be BPCZJLFJW");
}

type Stack = Vec<char>;
type Instruction = (u32, usize, usize);
type Input = (Vec<Stack>, Vec<Instruction>);

fn get_at<U: FromStr + Debug>(cap: &Captures, i: usize) -> U
where
    U: FromStr + Debug,
    <U as FromStr>::Err: Debug,
{
    cap.at(i).unwrap().parse::<U>().unwrap()
}

fn parse(filecontent: &str) -> (Vec<Stack>, Vec<Instruction>) {
    let lines: Vec<&str> = filecontent.split("\n").collect();

    let stacks_nr = (&lines[0].len() + 4 - 1) / 4;
    let mut stacks: Vec<Stack> = Vec::new();
    for _ in 0..stacks_nr {
        stacks.push(Vec::new());
    }

    // stacks
    for line in &lines {
        for (i, l) in line.as_bytes().chunks(4).enumerate() {
            if l[1] as char != ' ' {
                stacks[i].push(l[1] as char)
            }
        }
        if *line == "" {
            break;
        }
    }
    for stack in stacks.iter_mut() {
        stack.pop();
        stack.reverse();
    }

    // instruction
    let re = Regex::new(r"move (\d+) from (\d+) to (\d+)").unwrap();
    let mut instructions: Vec<Instruction> = Vec::new();
    for l in lines {
        if re.is_match(l) {
            let cap = re.captures(l).unwrap();
            instructions.push((
                get_at::<u32>(&cap, 1),
                get_at::<usize>(&cap, 2),
                get_at::<usize>(&cap, 3),
            ));
        }
    }

    (stacks, instructions)
}

fn part1((mut stacks, instr): Input) -> String {
    instr.iter().for_each(|(nr, f, t)| {
        (0..*nr).for_each(|_| {
            let c = stacks[*f - 1].pop().unwrap();
            stacks[*t - 1].push(c);
        });
    });

    stacks
        .iter_mut()
        .map(|s| s.pop().unwrap())
        .collect::<Vec<char>>()
        .iter()
        .cloned()
        .collect()
}

fn part2((mut stacks, instr): Input) -> String {
    instr.iter().for_each(|(nr, f, t)| {
        let mut tempstack: Vec<char> = Vec::new();
        (0..*nr).for_each(|_| {
            tempstack.push(stacks[*f - 1].pop().unwrap());
        });
        (0..*nr).for_each(|_| {
            stacks[*t - 1].push(tempstack.pop().unwrap());
        })
    });
    stacks
        .iter_mut()
        .map(|s| s.pop().unwrap())
        .collect::<Vec<char>>()
        .iter()
        .cloned()
        .collect()
}
