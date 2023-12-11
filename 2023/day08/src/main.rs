use std::fs;
use std::collections::HashMap;
use std::collections::HashSet;

#[test]
fn tests() {
    {
        let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
        let input = parse(contents);
        let res_p1 = part1(&input);
        assert!(res_p1 == 2);
    }

    {
        let contents: &str = &fs::read_to_string("input_test_2.txt").expect("Failure");
        let input = parse(contents);
        let res_p2 = part2(&input);
        assert!(res_p2 == 6);
    }
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    println!("part 1: {res_p1} | should be 15871");

    let res_p2 = part2(&input);
    println!("part 2: {res_p2} | should be XXXX");
}




fn parse(filecontent: &str) -> (&str, HashMap<String, String>) {
    let lines: Vec<&str> = filecontent.lines().collect();
    let mut hash: HashMap<String, String> = HashMap::new();
    let parts= regex::Regex::new(r"(?<orig>\w+) = \((?<left>\w+), (?<right>\w+)\)").unwrap(); 

    for line in &lines[2..] {
        let caps = parts.captures(line).unwrap();
        let orig = (&caps["orig"]).to_string();
        let left = (&caps["left"]).to_string();
        let right = (&caps["right"]).to_string();
        let origL= orig.clone() + "L";
        let origR= orig.clone() + "R";
        hash.insert(origL, left);
        hash.insert(origR, right);
    }

    (lines[0], hash)
}

fn part1(input: &(&str, HashMap<String, String>)) -> u32 {
    let ( instr, hash ) = input;
    let mut steps: usize = 0;
    let mut dest: &str = "AAA";

    while dest != "ZZZ" {
        let side = &instr.chars().nth(steps % instr.len()).unwrap().to_string();
        let newKey = dest.clone().to_owned() + side;
        dest = &hash[&newKey];
        steps += 1;
    }
    steps as u32
}

fn part2(input: &(&str, HashMap<String, String>)) -> u32 {
    let ( instr, hash ) = input;
    let lenInstr = instr.len();
    let instrStr: Vec<String> = instr.chars().map(|x| x.to_string()).collect();
    let mut steps: usize = 0;
    let dest: HashSet<&str> = hash.keys().into_iter()
        .map(|x| &x[0..3])
        .filter(|&x| x.ends_with("A"))
        .collect();

    let mut destinations: Vec<&str> = dest.into_iter().collect();
    while !destinations.iter().all(|x| x.ends_with("Z")) {
        let side: &str= &instrStr[steps % lenInstr];
        destinations = destinations
            .iter()
            .map(|x| x.to_string() + &side)
            .map(|x| {
                let newDest = &hash[&x];
                newDest.as_str()
            }).collect();
        if steps % 1000 == 0{
            println!("steps: {}", steps);
        }
        steps += 1;
    }
    steps as u32
}