use std::fs;
use std::collections::HashSet;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 4361);
    assert!(res_p2 == 467835);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | should be 550064");
    println!("part 2: {res_p2} | should be 85010461");
}

fn parse(filecontent: &str) -> Vec<&str> {
    filecontent.lines().collect()
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
struct Ship (u32, usize, usize); // value, from, to -- the row is the index in the vector;
type Bomb = (usize, usize, char); // x, y

fn fill_ships_and_bombs(ships: &mut Vec<Vec<Ship>>, bombs: &mut Vec<Bomb>, lines: &[&str]) {
    let mut read_value = 0;
    let mut read_from: usize = 0;
    let mut read_to: usize = 0;
    let mut reading = false;

    for (line_idx, line) in lines.iter().enumerate() {
        ships.push(Vec::new());
        reading = false;
        for (i, c) in line.chars().enumerate() {
            if c.is_digit(10) {
                if !reading {
                    read_from = i;
                }
                reading = true;
                read_value = read_value * 10 + c.to_digit(10).unwrap();
            } else {
                if reading {
                    read_to = i - 1;
                    ships[line_idx].push(Ship(read_value, read_from, read_to));
                    read_value = 0;
                    reading = false;
                    read_from = 0;
                }
                if c != '.' {
                    bombs.push((line_idx, i, c));
                    reading = false;
                }
            }
        }
        if reading {
            read_to = line.len() - 1;
            ships[line_idx].push(Ship(read_value, read_from, read_to));
            read_value = 0;
            read_from = 0;
            reading = false;
        }
    }
}


fn part1(lines: &[&str]) -> u32 {
    let mut ships: Vec<Vec<Ship>> = Vec::new();
    let mut bombs: Vec<Bomb> = Vec::new();

    fill_ships_and_bombs(&mut ships, &mut bombs, lines);

    let mut ships_hitted : HashSet<Ship> = HashSet::new();
    for (x, y, _) in bombs {
        let lines_to_test = match x {
            0 => vec![x, x + 1],
            n if n == ships.len() - 1 => vec![x - 1, x],
            _ => vec![x - 1, x, x + 1],
        };
        lines_to_test.iter().for_each(|line| {
            let filtered = ships[*line]
                .iter()
                .filter(|Ship(_, from, to)| y + 1 >= *from && y - 1 <= *to);
            filtered.for_each(|s| {
                ships_hitted.insert(*s);
            });
        })
    }
    ships_hitted.iter().map(|Ship(v, _, _)| v).sum::<u32>()
}

fn part2(lines: &[&str]) -> u32 {
    let mut ships: Vec<Vec<Ship>> = Vec::new();
    let mut bombs: Vec<Bomb> = Vec::new();
    fill_ships_and_bombs(&mut ships, &mut bombs, lines);

    bombs = bombs.iter().filter(|(_, _, c)| *c == '*').cloned().collect();
    let mut sum = 0;
    for (x, y, _) in bombs {
        let mut ships_hitted : Vec<Ship> = vec![];
        let lines_to_test = match x {
            0 => vec![x, x + 1],
            n if n == ships.len() - 1 => vec![x - 1, x],
            _ => vec![x - 1, x, x + 1],
        };
        lines_to_test.iter().for_each(|line| {
            ships[*line]
                .iter()
                .filter(|Ship(_, from, to)| y + 1 >= *from && y - 1 <= *to)
                .cloned()
                .for_each(|s| { ships_hitted.push(s) });
        });
        if ships_hitted.len() == 2 {
            let ss: u32 = ships_hitted.iter().fold(1, |acc, &Ship(v,_,_)| acc * v); // multiply the values
            sum += ss;
        }
    }
    sum
}
