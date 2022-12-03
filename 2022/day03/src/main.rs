use std::collections::HashSet;
use std::fs;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("cannot read the file");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 157);
    assert!(res_p2 == 70);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("cannot read the file");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} (should be 8243)");
    println!("part 2: {res_p2} (should be 2631)");
}

fn parse(filecontent: &str) -> Vec<&str> {
    filecontent.lines().collect()
}

fn char_value(c: char) -> u32 {
    if c as u32 >= b'a' as u32 {
        return c as u32 - b'a' as u32 + 1;
    }
    c as u32 - b'A' as u32 + 27
}

fn part1(rucksacks: &[&str]) -> u32 {
    let mut sumt: u32 = 0;
    for rucksack in rucksacks {
        let half = rucksack.len() / 2;
        let set1: HashSet<char> = rucksack[0..half].chars().collect();
        let set2: HashSet<char> = rucksack[half..].chars().collect();
        let set3 = set1.intersection(&set2);
        sumt += set3.map(|s| char_value(*s)).sum::<u32>();
    }
    sumt
}

fn part2(rucksacks: &[&str]) -> u32 {
    let mut sumt: u32 = 0;

    for rs in rucksacks.chunks(3) {
        let mut sets = rs.iter().map(|r| r.chars().collect::<HashSet<char>>());
        // intersection of multiple sets apparently is not easy in Rust.. thank you internet for the help
        let base = sets.next().unwrap().clone();
        let intersection = sets.fold(base, |acc, set| acc.intersection(&set).copied().collect());

        sumt += intersection.iter().map(|s| char_value(*s)).sum::<u32>();
    }
    sumt
}
