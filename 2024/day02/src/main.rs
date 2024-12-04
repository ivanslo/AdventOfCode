use std::iter::zip;

use nom::{
    character::complete::{digit1, newline, space1},
    combinator::map_res,
    multi::{separated_list0, separated_list1},
    IResult,
};

type Num = i32;
type Line = Vec<Num>;

fn parse(input: &str) -> Vec<Line> {
    let ss: IResult<&str, Vec<Line>> = separated_list0(
        newline,
        separated_list1(space1, map_res(digit1, str::parse)),
    )(input);
    ss.unwrap().1
}

fn is_increasing(levels: &Line) -> bool {
    zip(&levels[0..], &levels[1..]).all(|(a, b)| a < b)
}

fn is_decreasing(levels: &Line) -> bool {
    zip(&levels[0..], &levels[1..]).all(|(a, b)| a > b)
}

fn are_differences_small(levels: &Line) -> bool {
    zip(&levels[0..], &levels[1..]).all(|(a, b)| (a - b).abs() <= 3 && a != b)
}

fn is_valid(levels: &Line) -> bool {
    (is_increasing(levels) || is_decreasing(levels)) && are_differences_small(levels)
}

fn part1(input: &str) -> Num {
    parse(input)
        .into_iter()
        .filter(is_valid)
        .collect::<Vec<Line>>()
        .len() as Num
}

fn part2(input: &str) -> Num {
    parse(input)
        .into_iter()
        .filter(|levels| {
            (0..levels.len())
                .map(|i| vec![&levels[0..i], &levels[i + 1..]].concat())
                .any(|l| is_valid(&l))
        })
        .collect::<Vec<Line>>()
        .len() as Num
}

fn main() {
    {
        let result = part1(include_str!("../input.txt"));
        println!("part 1: {result} | expected 680");
    }
    {
        let result = part2(include_str!("../input.txt"));
        println!("part 2: {result} | expected 710");
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example_part_1() {
        assert_eq!(part1(include_str!("../input_test.txt")), 2);
    }
    #[test]
    fn example_part_2() {
        assert_eq!(part2(include_str!("../input_test.txt")), 4);
    }
}
