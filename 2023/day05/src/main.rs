use std::fs;
use std::collections::HashSet;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 35);
    assert!(res_p2 == 46);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 226172555");
    println!("part 2: {res_p2} | should be XXXXXXXXX");
}

#[derive(Debug)]
struct Map {
    destination_rs: u64,
    source_rs: u64,
    range: u64,
}
#[derive(Debug)]
struct Description {
    source: String,
    destination: String,
    maps: Vec<Map>,
}

type ParsedInput = (Vec<Description>, Vec<u64>);

fn parse(filecontent: &str) -> ParsedInput {
    let title_regex = regex::Regex::new(r"(?<source>\w+)-to-(?<destination>\w+) map:").unwrap();
    let l: Vec<&str> = filecontent.lines().collect();
    let seeds = l[0].split(":").collect::<Vec<&str>>()[1].
            trim().split(" ").map(|x| x.parse::<u64>().unwrap())
            .collect::<Vec<u64>>();

    let mut descriptions = Vec::<Description>::new();

    l[2..].split(|line| *line == "").for_each(|description| {
        let names = title_regex.captures(description[0]).unwrap();
        let mut descr = Description {
            source: (&names["source"]).to_string(),
            destination: (&names["destination"]).to_string(),
            maps: Vec::<Map>::new(),
        };
        description[1..].iter().for_each(|line| {
            let nrs = line.split(" ").map(|x| x.parse::<u64>().unwrap()).collect::<Vec<u64>>();
            descr.maps.push(Map {
                destination_rs: nrs[0],
                source_rs: nrs[1],
                range: nrs[2],
            });
        });
        descriptions.push(descr);
    });

    (descriptions, seeds)
}

fn get_min_location(seeds: &Vec<u64>, descriptions: &Vec<Description>) -> u64 {
    seeds.iter().map(| initialseed | {
        descriptions.iter().fold(*initialseed, |seed, description| {
            description.maps.iter()
                .find( | Map { source_rs, destination_rs, range} | {
                    seed >= *source_rs && seed < *source_rs + *range
                })
                .map_or(seed, |m| m.destination_rs + seed - m.source_rs)
        })
    }).min().unwrap()
}


fn part1(lines: &ParsedInput) -> u64 {
    get_min_location(&lines.1, &lines.0)
}

fn part2(lines: &ParsedInput) -> u64 {
    // TO-DO: do mapping for ranges.
    // one by one is sloooowww
    // possibilities: 
    // () a source fits perfectly
    // () a source has leftover in one side (tail or head)
    // () a source has leftover in both sides (tail and head)
    let ( maps_input, seed_input ) = lines;
    let mut seeds = Vec::<u64>::new();

    println!("before {:?}", seeds.len());
    seed_input.chunks(2).for_each( |c| {
        seeds.extend(c[0]..(c[0]+c[1]));
    });
    println!("after {:?}", seeds.len());

    get_min_location(&seeds, &maps_input)
    // 46
}
