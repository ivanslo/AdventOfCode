use std::cmp::Ordering;
use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("cannot read the file");
    let input = parse(contents.clone());
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 15);
    assert!(res_p2 == 12);
}

fn main() {
    {
        let contents = fs::read_to_string("input.txt").expect("cannot read the file");
        let input = parse(contents);
        let res_p1 = part1(&input);
        let res_p2 = part2(&input);
        println!("part 1: {res_p1}");
        println!("part 2: {res_p2}");
    }
}
fn parse(filecontent: String) -> Vec<(char, char)> {
    filecontent
        .lines()
        .map(|line| (line.chars().nth(0).unwrap(), line.chars().nth(2).unwrap()))
        .collect()
}

fn part1(games: &[(char, char)]) -> u32 {
    games
        .iter()
        .map(|(c1, c2)| (RPS::from_char(*c1), RPS::from_char(*c2)))
        .map(|(elf, me)| {
            me.val()
                + match me.cmp(&elf) {
                    Ordering::Less => 0,
                    Ordering::Equal => 3,
                    Ordering::Greater => 6,
                }
        })
        .sum()
}

fn part2(games: &[(char, char)]) -> u32 {
    games
        .iter()
        .map(|(elf, result)| match result {
            'X' => ((RPS::from_char(*elf).val() + 1) % 3) + 1,
            'Y' => 3 + RPS::from_char(*elf).val(),
            'Z' => 6 + (RPS::from_char(*elf).val() % 3) + 1,
            _ => 0,
        })
        .sum()
}

enum RPS {
    Rock,
    Paper,
    Scissor,
}

impl RPS {
    fn from_char(c: char) -> RPS {
        match c {
            'A' => RPS::Rock,
            'B' => RPS::Paper,
            'C' => RPS::Scissor,
            'X' => RPS::Rock,
            'Y' => RPS::Paper,
            'Z' => RPS::Scissor,
            _ => RPS::Rock,
        }
    }

    fn val(&self) -> u32 {
        match self {
            RPS::Rock => 1,
            RPS::Paper => 2,
            RPS::Scissor => 3,
        }
    }
}

impl PartialOrd for RPS {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for RPS {
    fn eq(&self, other: &Self) -> bool {
        self == other
    }
}

impl Eq for RPS {}

impl Ord for RPS {
    fn cmp(&self, other: &Self) -> Ordering {
        match self {
            RPS::Rock => match other {
                RPS::Rock => Ordering::Equal,
                RPS::Paper => Ordering::Less,
                RPS::Scissor => Ordering::Greater,
            },
            RPS::Paper => match other {
                RPS::Rock => Ordering::Greater,
                RPS::Paper => Ordering::Equal,
                RPS::Scissor => Ordering::Less,
            },
            RPS::Scissor => match other {
                RPS::Rock => Ordering::Less,
                RPS::Paper => Ordering::Greater,
                RPS::Scissor => Ordering::Equal,
            },
        }
    }
}
