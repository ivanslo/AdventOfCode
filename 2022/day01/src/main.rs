use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("cannot read the file");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 24000);
    assert!(res_p2 == 45000);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("cannot read the file");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1}");
    println!("part 2: {res_p2}");
}

fn parse(filecontent: String) -> Vec<Vec<u32>> {
    let lines: Vec<Vec<u32>> = filecontent
        .lines()
        .map(|x| x.parse::<String>().unwrap())
        .collect::<Vec<String>>()
        .split(|x| x.is_empty())
        .map(|group| group.iter().map(|x| x.parse::<u32>().unwrap()).collect())
        .collect();
    lines
}

fn part1(numbers: &[Vec<u32>]) -> u32 {
    numbers
        .iter()
        .map(|nrs| nrs.iter().sum::<u32>())
        .max()
        .unwrap_or(0)
}

fn part2(numbers: &[Vec<u32>]) -> u32 {
    let mut nrs = numbers
        .iter()
        .map(|nrs| nrs.iter().sum())
        .collect::<Vec<u32>>();

    nrs.sort_by(|a, b| b.cmp(a));

    nrs.iter().take(3).sum()
}
