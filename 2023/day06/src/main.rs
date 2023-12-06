use std::fs;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");

    let input = parse(contents);
    let res_p1 = part1(&input);

    let input_p2 = parse_p2(contents);
    let res_p2 = part2(&input_p2);

    assert!(res_p1 == 288);
    assert!(res_p2 == 71503);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");

    let input = parse(contents);
    let res_p1 = part1(&input);

    let input_p2 = parse_p2(contents);
    let res_p2 = part2(&input_p2);

    println!("part 1: {res_p1} | should be 1159152");
    println!("part 2: {res_p2} | should be 41513103");
}

// #[derive(Debug)]
type TimeDistance = (i64, i64);
type ParsedInput = Vec<TimeDistance>;

fn parse(filecontent: &str) -> ParsedInput {
    let nrs = regex::Regex::new(r"(\d+)").unwrap();
    let lines = filecontent
        .lines()
        .map(|line| {
            nrs.captures_iter(line)
                .map(|cap| cap[1].parse::<i64>().unwrap())
                .collect::<Vec<i64>>()
        })
        .collect::<Vec<Vec<i64>>>();

    let l = lines[0].len();
    (0..l)
        .map(|i| (lines[0][i], lines[1][i]))
        .collect::<ParsedInput>()
}

fn parse_p2(filecontent: &str) -> TimeDistance {
    let nrs = regex::Regex::new(r"(\d+)").unwrap();
    let a = filecontent
        .lines()
        .map(|line| {
            nrs.captures_iter(line)
                .map(|cap| cap[1].to_string())
                .collect::<Vec<String>>()
                .join("")
        })
        .map(|x| x.parse::<i64>().unwrap())
        .collect::<Vec<i64>>();
    println!("{:?}", a);

    (a[0], a[1])
}

fn get_ways_of_winning(timeDistance: TimeDistance) -> i64 {
    // solve the roots of the quadratic equation, and pick the ceil/floor of the roots
    // as the start and end of the range
    // if they're integers, add/substract 1 to them (since we don't want to draw, but win)
    //
    // height =  time * x - x^2
    //  =>  0 = -x^2 + time * x - height
    //
    let tt = timeDistance.0 as f64;
    let hh = timeDistance.1 as f64;
    let r1 = tt / 2.0 - (tt * tt - 4.0 * hh).sqrt() / 2.0;
    let r2 = tt / 2.0 + (tt * tt - 4.0 * hh).sqrt() / 2.0;
    let ss1: i64 = match r1.fract() {
        0.0 => r1 as i64 + 1,
        _ => r1.ceil() as i64,
    };
    let ss2: i64 = match r2.fract() {
        0.0 => r2 as i64 - 1,
        _ => r2.floor() as i64,
    };
    ss2 - ss1 + 1
}

fn part1(lines: &ParsedInput) -> i64 {
    let ways = lines
        .iter()
        .map(|x| get_ways_of_winning(*x))
        .fold(1, |acc, x| acc * x);
    ways
}

fn part2(lines: &TimeDistance) -> i64 {
    get_ways_of_winning(*lines)
}
