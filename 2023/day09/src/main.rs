use std::fs;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 114);
    assert!(res_p2 == 2);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 1904165718");
    println!("part 2: {res_p2} | should be 964");
}

fn parse(filecontent: &str) -> Vec<Vec<i32>> {
    filecontent.lines().map(
        |line| line.split(" ").map(
            |num| num.parse::<i32>().unwrap()
        ).collect()
    )
    .collect()
}


fn part1(lines: &Vec<Vec<i32>>) -> i32 {
    fn calc_sum(vals: &Vec<i32>) -> i32 {
        if vals.iter().all(|v| *v == 0) {
            return 0;
        }
        let mut subs: Vec<i32> = Vec::new();
        for (i, v) in vals.iter().enumerate() {
            if i == vals.len() - 1 { break; }
            subs.push(vals[i+1] - v);
        }
        vals.last().unwrap() + calc_sum(&subs)
    }
    lines.iter().map( calc_sum ).sum()
}

fn part2(lines: &Vec<Vec<i32>>) -> i32 {
    fn calc_sum(vals: &Vec<i32>) -> i32 {
        if vals.iter().all(|v| *v == 0) {
            return 0;
        }
        let mut subs: Vec<i32> = Vec::new();
        for (i, v) in vals.iter().enumerate() {
            if i == vals.len() - 1 { break; }
            subs.push(vals[i+1] - v);
        }
        vals.first().unwrap() - calc_sum(&subs)
    }
    lines.iter().map( calc_sum ).sum()
}
