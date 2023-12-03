use std::fs;
use std::collections::HashMap;

#[test]
fn tests() {
    {
        let contents = fs::read_to_string("input_test.txt").expect("Failure");
        let input: Vec<String> = parse(contents);
        let res_p1 = part1(&input);
        assert!(res_p1 == 142);
    }
    {
        let contents = fs::read_to_string("input_test_p2.txt").expect("Failure");
        let input: Vec<String> = parse(contents);
        let res_p2 = part2(&input);
        assert!(res_p2 == 281);
    }
}

fn main() {
    {
        let contents = fs::read_to_string("input.txt").expect("Failure");
        let input: Vec<String> = parse(contents);
        let res_p1 = part1(&input);
        println!("part 1: {res_p1} | expected 53974");
    }
    {
        let contents = fs::read_to_string("input.txt").expect("Failure");
        let input: Vec<String> = parse(contents);
        let res_p2 = part2(&input);
        println!("part 2: {res_p2} | expected 52840");
    }
}

fn parse(filecontent: String) -> Vec<String> {
    filecontent.lines().map(String::from).collect()
}

fn part1(lines: &Vec<String>) -> u32 {
    let mut sum: u32 = 0;
    lines.iter().for_each(|line| {
        let digits = line
            .chars()
            .filter(|c| c.is_digit(10))
            .map(|x| x.to_digit(10).unwrap())
            .collect::<Vec<u32>>();
        sum += digits.first().unwrap() * 10 + digits.last().unwrap();
    });
    sum
}

fn part2(lines: &Vec<String>) -> u32 {
    let mut words: HashMap<String, u32> = HashMap::new();
    words.insert(String::from("one"), 1);
    words.insert(String::from("two"), 2);
    words.insert(String::from("three"), 3);
    words.insert(String::from("four"), 4);
    words.insert(String::from("five"), 5);
    words.insert(String::from("six"), 6);
    words.insert(String::from("seven"), 7);
    words.insert(String::from("eight"), 8);
    words.insert(String::from("nine"), 9);
    words.insert(String::from("zero"), 0);
    words.insert(String::from("1"), 1);
    words.insert(String::from("2"), 2);
    words.insert(String::from("3"), 3);
    words.insert(String::from("4"), 4);
    words.insert(String::from("5"), 5);
    words.insert(String::from("6"), 6);
    words.insert(String::from("7"), 7);
    words.insert(String::from("8"), 8);
    words.insert(String::from("9"), 9);
    words.insert(String::from("0"), 0);

    let regex_f = regex::Regex::new(r"(one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9|0)").unwrap();
    let regex_r = regex::Regex::new(r"(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|1|2|3|4|5|6|7|8|9|0)").unwrap();

    let mut sum : u32= 0;
    lines.iter().for_each(|line| {
        let line_r = line.chars().rev().collect::<String>();

        let matches_f: Vec<_> = regex_f.captures_iter(line).collect();
        let first = matches_f.first().unwrap().get(0).unwrap().as_str();
        let matches_r: Vec<_> = regex_r.captures_iter(&line_r).collect();
        let last = matches_r.first().unwrap().get(0).unwrap().as_str().chars().rev().collect::<String>();

        sum += words[first] * 10 + words[&last];
    });

    sum
}
