use std::fmt::Debug;
use std::fs;

#[derive(Debug, Eq, PartialEq, Hash, Clone)]
struct Input {
    winning_numbers: Vec<u32>,
    my_numbers: Vec<u32>,
}

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(&contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 13);
    assert!(res_p2 == 30);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(&contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 18519");
    println!("part 2: {res_p2} | should be 11787590");
}

fn parse(filecontent: &str) -> Vec<Input> {
    let mut all_lines: Vec<Input> = Vec::new();
    filecontent.lines().for_each(|line| {
        let parts: Vec<&str> = line.split(':').collect::<Vec<&str>>()[1]
            .split('|')
            .map(|x| x.trim())
            .collect();
        let part1: Vec<u32> = parts[0]
            .split_whitespace()
            .map(|x| x.parse::<u32>().unwrap())
            .collect();
        let part2: Vec<u32> = parts[1]
            .split_whitespace()
            .map(|x| x.parse::<u32>().unwrap())
            .collect();
        all_lines.push(Input {
            winning_numbers: part1,
            my_numbers: part2,
        });
    });
    all_lines
}

fn part1(inputs: &Vec<Input>) -> u32 {
    inputs
        .iter()
        .map( |Input { winning_numbers, my_numbers }| {
                let count = my_numbers
                    .iter()
                    .filter(|x| winning_numbers.contains(x))
                    .count();
                match count {
                    0 => 0,
                    _ => u32::pow(2, count as u32 - 1),
                }
            },
        ).sum()
}

fn part2(inputs: &Vec<Input>) -> u32 {
    let mut cards_counter: Vec<u32> = vec![1; inputs.len()];
    let mut winners_in: Vec<u32> = vec![0; inputs.len()];

    inputs.iter().enumerate().for_each(|(i, Input { winning_numbers, my_numbers })| {
        winners_in[i] = my_numbers.iter().filter(|x| winning_numbers.contains(x)).count() as u32
    });
    
    (0..inputs.len()).for_each(|i| {
        (i+1..(winners_in[i] as usize +i+1)).for_each(|j| {
            cards_counter[j] += cards_counter[i];
        });
    });
    cards_counter.iter().sum::<u32>()
}
