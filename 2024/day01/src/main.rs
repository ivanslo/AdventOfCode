use std::{collections::HashMap, fs, iter::zip};

#[test]
fn tests() {
    {
        let contents = fs::read_to_string("input_test.txt").expect("Failure");
        let input: Vec<(i32, i32)> = parse(contents);
        let res_p1 = part1(&input);
        assert!(res_p1 == 11);
    }
    {
        let contents = fs::read_to_string("input_test.txt").expect("Failure");
        let input: Vec<(i32, i32)> = parse(contents);
        let res_p2 = part2(&input);
        assert!(res_p2 == 31);
    }
}

fn main() {
    {
        let contents = fs::read_to_string("input.txt").expect("Failure");
        let input: Vec<(i32, i32)> = parse(contents);
        let res_p1 = part1(&input);
        println!("part 1: {res_p1} | expected 2904518");
    }
    {
        let contents = fs::read_to_string("input.txt").expect("Failure");
        let input: Vec<(i32, i32)> = parse(contents);
        let res_p2 = part2(&input);
        println!("part 2: {res_p2} | expected 18650129");
    }
}

fn parse(filecontent: String) -> Vec<(i32, i32)> {
    filecontent
        .lines()
        .map(|line: &str| {
            let p: Vec<&str> = line.split("   ").collect();
            (p[0].parse::<i32>().unwrap(), p[1].parse::<i32>().unwrap())
        })
        .collect()
}

fn part1(lines: &Vec<(i32, i32)>) -> i32 {
    let mut s: i32 = 0;
    let mut v1: Vec<i32> = lines.iter().map(|l| l.0).collect();
    let mut v2: Vec<i32> = lines.iter().map(|l| l.1).collect();
    v1.sort();
    v2.sort();

    zip(v1, v2).for_each(|pp| s += i32::abs(pp.0 - pp.1));
    s
}

fn part2(lines: &Vec<(i32, i32)>) -> i32 {
    let v1: Vec<i32> = lines.iter().map(|l| l.0).collect();
    let v2: Vec<i32> = lines.iter().map(|l| l.1).collect();

    let freq = v2.iter().fold(HashMap::new(), |mut map, v| {
        map.entry(v).and_modify(|c| *c += 1).or_insert(1);
        map
    });

    v1.iter()
        .map(|v| v * freq.get(v).copied().unwrap_or(0))
        .sum::<i32>()
}
