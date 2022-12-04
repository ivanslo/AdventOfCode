use onig::{Captures, Regex};
use std::fs;

type FromTo = ((u16,u16),(u16,u16));

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Vec<FromTo> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 2);
    assert!(res_p2 == 4);
}


fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Vec<FromTo> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1}");
    println!("part 2: {res_p2}");
}

fn parse(filecontent: String) -> Vec<FromTo> {
    let re = Regex::new(r"([0-9]+)-([0-9]+),([0-9]+)-([0-9]+)").unwrap();

    fn get_nr(cap: &Captures, i: usize) -> u16 {
        cap.at(i).unwrap().parse::<u16>().unwrap()
    }

    filecontent
        .lines()
        .map(|x| {
            let cap = re.captures(x).unwrap();
            (
                (get_nr(&cap, 1), get_nr(&cap, 2)),
                (get_nr(&cap, 3), get_nr(&cap, 4)),
            )
        })
        .collect()
}

fn part1(numbers: &[FromTo]) -> u32 {
    numbers
        .iter()
        .map(|((f1, t1), (f2, t2))| (f1 <= f2 && t1 >= t2) || (f2 <= f1 && t2 >= t1))
        .filter(|x| *x)
        .count() as u32
}

fn part2(numbers: &[FromTo]) -> u32 {
    numbers
        .iter()
        .map(|((f1, t1), (f2, t2))| (f1 <= f2 && t1 >= f2) || (f2 <= f1 && t2 >= f1))
        .filter(|x| *x)
        .count() as u32
}
