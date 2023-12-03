use std::fs;
use std::collections::HashMap;
use std::cmp;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Vec<String> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 8);
    assert!(res_p2 == 2286);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Vec<String> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 1867");
    println!("part 2: {res_p2} | should be 84538");
}

fn parse(filecontent: String) -> Vec<String> {
    filecontent.lines().map(String::from).collect()
}

fn part1(lines: &Vec<String>) -> u32 {
    let gameregex= regex::Regex::new(r"Game (\d+): (.*)").unwrap();
    let bagregex = regex::Regex::new(r"\s?(\d+) (red|blue|green)").unwrap();

    let mut limits : HashMap<String, u32> = HashMap::new();
    limits.insert(String::from("red"), 12);
    limits.insert(String::from("green"), 13);
    limits.insert(String::from("blue"), 14);

    let mut sum = 0;
    lines.iter().for_each(|line| {
        let caps = gameregex.captures(line).unwrap();
        let game_nr = caps.get(1).unwrap().as_str().parse::<u32>().unwrap();
        let game = caps.get(2).unwrap().as_str();
        
        let cubes = game.split(";").collect::<Vec<&str>>();
        let possib = cubes.iter().all(|cube| {
            let bags = cube.split(",").collect::<Vec<&str>>();
            bags.iter().all(|bag| {
                let bb = bagregex.captures(bag).unwrap();
                let nr = bb.get(1).unwrap().as_str().parse::<u32>().unwrap();
                let colour = bb.get(2).unwrap().as_str();

                return nr <= limits[colour]
            })
        });
        sum += match possib { true => game_nr, false => 0 } 
    });
    sum
}

fn part2(lines: &Vec<String>) -> u32 {
    let bagregex = regex::Regex::new(r"\s?(\d+) (red|blue|green)").unwrap();

    let mut total = 0;
    lines.iter().for_each(|line| {
        let mut needed : HashMap<String, u32> = HashMap::from([
            (String::from("red"), 0),
            (String::from("blue"), 0),
            (String::from("green"), 0),
        ]);

        let cubes : Vec<&str> = line.split(":").collect::<Vec<&str>>()[1].split(";").collect::<Vec<&str>>();

        cubes.iter().for_each(|cube| {
            let bags = cube.split(",").collect::<Vec<&str>>();
            bags.iter().for_each(|bag| {
                let bb = bagregex.captures(bag).unwrap();
                let nr = bb.get(1).unwrap().as_str().parse::<u32>().unwrap();
                let colour = bb.get(2).unwrap().as_str();

                needed.insert(String::from(colour), cmp::max(needed[colour], nr));
            })
        });

        let minimum = needed["red"] * needed["blue"] * needed["green"];

        total += minimum;
    });
    total
}
