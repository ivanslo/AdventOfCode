use itertools::Itertools; // for `unique`
use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Vec<char> = parse(contents);
    let res_p1 = part1(&input);
    assert!(res_p1 == 7);
    assert!(part1(&parse(String::from("bvwbjplbgvbhsrlpgdmjqwftvncz"))) == 5);
    assert!(part1(&parse(String::from("nppdvjthqldpwncqszvftbrmjlhg"))) == 6);
    assert!(part1(&parse(String::from("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"))) == 10);
    assert!(part1(&parse(String::from("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))) == 11);

    assert!(part2(&parse(String::from("mjqjpqmgbljsphdztnvjfqwrcgsmlb"))) == 19);
    assert!(part2(&parse(String::from("bvwbjplbgvbhsrlpgdmjqwftvncz"))) == 23);
    assert!(part2(&parse(String::from("nppdvjthqldpwncqszvftbrmjlhg"))) == 23);
    assert!(part2(&parse(String::from("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"))) == 29);
    assert!(part2(&parse(String::from("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))) == 26);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Vec<char> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 1757");
    println!("part 2: {res_p2} | should be 2950");
}

fn parse(filecontent: String) -> Vec<char> {
    filecontent.chars().collect()
}

fn solution_for(input: &[char], wsize: usize) -> usize {
    wsize
        + input
            .windows(wsize)
            .position(|w| w.iter().unique().count() == wsize)
            .unwrap()
}

fn part1(input: &[char]) -> usize {
    solution_for(input, 4)
}

fn part2(input: &[char]) -> usize {
    solution_for(input, 14)
}
