use std::collections::HashMap;
use std::fs;
use std::ops::Index;
use std::thread::current;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    // let res_p2 = part2(&input);
    assert!(res_p1 == 0);
    // assert!(res_p2 == 0);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    // let res_p2 = part2(&input);
    // println!("part 1: {res_p1}");
    // println!("part 2: {res_p2}");
}

#[derive(Debug)]
enum Comparator {
    LessThan,
    GreaterThan,
}
#[derive(Debug)]
struct Rule {
    letter: char,
    condition: Comparator,
    value: u32,
    output: String,
}

#[derive(Debug)]
struct Rating {
    x: u32,
    m: u32,
    a: u32,
    s: u32,
}

impl Index<&'_ str> for Rating {
    type Output = u32;

    fn index(&self, index: &str) -> &Self::Output {
        match index {
            "x" => &self.x,
            "m" => &self.m,
            "a" => &self.a,
            "s" => &self.s,
            _ => panic!("Unknown index"),
        }
    }
}

type Rules = HashMap<String, (Vec<Rule>, String)>;
type Input = (Rules, Vec<Rating>);

fn parseRules(lines: Vec<&str>) -> Rules {
    let mut rules: Rules = HashMap::new();
    let regex = regex::Regex::new(r"(?<name>\w+)\{(?<rest>.*)\}").unwrap();
    let rule =
        regex::Regex::new(r"(?<letter>[xmas]{1})(?<condition>[<>]{1})(?<value>\d+):(?<output>\w+)")
            .unwrap();

    lines.iter().for_each(|map| {
        let captures = regex.captures(map).unwrap();
        let name = (&captures["name"]).to_string();
        let name2 = name.clone();
        rules.insert(name, (Vec::new(), "".to_string()));

        let restt: Vec<&str> = captures["rest"].split(",").collect();
        restt.iter().for_each(|line| {
            if let Some(captures) = rule.captures(line) {
                let letter = (&captures["letter"]).to_string();
                let condition = (&captures["condition"]).to_string();
                let value = (&captures["value"]).to_string();
                let output = (&captures["output"]).to_string();

                rules.get_mut(&name2).unwrap().0.push(Rule {
                    letter: letter.chars().next().unwrap(),
                    condition: match condition.as_str() {
                        "<" => Comparator::LessThan,
                        ">" => Comparator::GreaterThan,
                        _ => panic!("Unknown comparator"),
                    },
                    value: value.parse::<u32>().unwrap(),
                    output: output.to_string(),
                });
            } else {
                rules.get_mut(&name2).unwrap().1 = line.to_string();
            }
        });
    });
    rules
}

fn parse_ratings(lines: Vec<&str>) -> Vec<Rating> {
    let re_value_memb =
        regex::Regex::new(r"\{x=(?<x>\d+),m=(?<m>\d+),a=(?<a>\d+),s=(?<s>\d+)\}").unwrap();

    lines
        .iter()
        .map(|line| {
            let capt = re_value_memb.captures(line).unwrap();
            Rating {
                x: (&capt["x"]).parse::<u32>().unwrap(),
                m: (&capt["m"]).parse::<u32>().unwrap(),
                a: (&capt["a"]).parse::<u32>().unwrap(),
                s: (&capt["s"]).parse::<u32>().unwrap(),
            }
        })
        .collect()
}

fn parse(filecontent: &str) -> Input {
    let lines: Vec<&str> = filecontent.lines().collect();
    let parts: Vec<&[&str]> = lines.split(|line| *line == "").collect();

    let rules = parseRules(parts[0].to_vec());
    let ratings = parse_ratings(parts[1].to_vec());

    (rules, ratings)
}

fn part1(lines: &Input) -> u32 {
    let ( rules, rating ) = lines;
    // println!("{:?} {:?}", rules, rating);

    fn approved_or_not<'a>(rating: &'a Rating, rules: &Rules, current_rule: &'a str) -> &'a str{
        if current_rule == "A" || current_rule == "R" {
            return current_rule;
        }
        println!("rule: {:?}", rules[current_rule]);
        for rule in rules[current_rule] {
            if rating[rule.letter] < rule.value {
                return rule.output
            }
        }
        return rules[current]
        "A"
    }

    rating.iter().for_each(|r| {
        println!("approved or not {}", approved_or_not(r, rules, "in"));
    });
    0
}

// fn part2(lines: &Input) -> u32 {
//     0
// }
