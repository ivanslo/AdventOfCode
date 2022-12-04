use std::fs;
use std::str::FromStr;
use std::fmt::Debug;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Vec<u32> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 0);
    assert!(res_p2 == 0);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Vec<u32> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1}");
    println!("part 2: {res_p2}");
}

fn parse<T>(filecontent: String) -> Vec<T>
where
    T: FromStr + Debug,
    <T as FromStr>::Err: Debug,
{
    filecontent
        .lines()
        .map(|x| x.parse::<T>().unwrap())
        .collect()
}

fn part1(numbers: &Vec<u32>) -> u32 {
    0
}

fn part2(numbers: &Vec<u32>) -> u32 {
    0
}
