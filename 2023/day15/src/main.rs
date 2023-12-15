use std::fs;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 1320);
    assert!(res_p2 == 145);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 517015");
    println!("part 2: {res_p2} | should be 286104");
}

fn parse(filecontent: &str) -> Vec<&str> {
    filecontent.split(",").collect()
}

fn hash(input: &str) -> u32 {
    input
        .chars()
        .fold(0, |acc, f| ((acc + f as u32) * 17) % 256)
}

fn part1(input: &[&str]) -> u32 {
    input.iter().map(|x| hash(x)).sum()
}

type Stuff = (String, u32);
fn part2(input: &[&str]) -> u32 {
    let label_re = regex::Regex::new(r"(?<label>\w+)(?<operation>[-=])(?<value>\d+)?").unwrap();

    let mut vecs: Vec<Vec<Stuff>> = vec![vec![]; 256];

    input.iter().for_each(|instr| {
        let cap = label_re.captures(instr).unwrap();
        let hash_label = hash(&cap["label"]) as usize;

        let operation = &cap["operation"];
        let pos = vecs[hash_label]
            .iter()
            .position(|x| x.0 == cap["label"]);
        match operation {
            "-" => {
                if let Some(p) = pos {
                    vecs[hash_label].remove(p);
                }
            }
            "=" => {
                if let Some(p) = pos {
                    vecs[hash_label][p] = (
                        (&cap["label"]).to_string(),
                        cap["value"].parse::<u32>().unwrap(),
                    );
                } else {
                    vecs[hash_label].push((
                        (&cap["label"]).to_string(),
                        cap["value"].parse::<u32>().unwrap(),
                    ));
                }
            }
            _ => {
                panic!("Unknown operation")
            }
        }
    });
    vecs.iter()
        .enumerate()
        .map(|(i, vec)| {
            vec.iter()
                .enumerate()
                .map(|(j, (_, value))| (i + 1) as u32 * (j + 1) as u32 * *value)
                .sum::<u32>()
        })
        .sum()
}
