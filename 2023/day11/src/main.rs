use std::fs;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input, 99);
    assert!(res_p1 == 374);
    assert!(res_p2 == 8410);
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input, 999999);
    println!("part 1: {res_p1} | should be 9536038");
    println!("part 2: {res_p2} | should be 447744640566");
}

type Point = (usize,usize);

fn parse(filecontent: &str) -> (Vec<Point>, usize, usize) {
    let lines = filecontent.lines();
    let mut points : Vec<Point> = Vec::new();
    let mut rows = 0;
    let mut cols = 0;
    lines.enumerate().for_each(|(i, line)| {
        rows = i+1;
        line.chars().enumerate().for_each(|(j, c)| {
            cols = j+1;
            if c == '#' {
                points.push((i , j));
            }
        })
    });
    (points, rows, cols)
}


fn expand_universe(points: &Vec<Point>, rows: &Vec<usize>, cols: &Vec<usize>, inc: usize) -> Vec<Point> {
     points
        .iter()
        .map(|(x,y)| {
            let delta_x = rows.iter().filter(|i| *i < x).count();
            let delta_y = cols.iter().filter(|i| *i < y).count();
            ( *x + (delta_x*inc), *y + (delta_y*inc) )
        })
        .collect::<Vec<Point>>()
}

fn manhattan_distance(p1: &Point, p2: &Point) -> usize {
    let (x1,y1) = p1;
    let (x2,y2) = p2;
    (
        (*x1 as i32 - *x2 as i32).abs() + 
        (*y1 as i32 - *y2 as i32).abs()
    ).try_into().unwrap()
}

fn part1(input: &(Vec<Point>, usize, usize)) -> usize {
    let (points, rows, cols) = input;
    let emptyrows = (0..*rows).filter(|i| points.iter().all(|(x,_)| x != i)).collect();
    let emptycols = (0..*cols).filter(|j| points.iter().all(|(_,y)| y != j)).collect();

    let expanded = expand_universe(points, &emptyrows, &emptycols, 1);

    let mut sum = 0;
    for i in 0..(expanded.len()-1) {
        for j in (i+1)..expanded.len() {
            sum += manhattan_distance(&expanded[i], &expanded[j]);
        }   
    }
    sum
}

fn part2(input: &(Vec<Point>, usize, usize), inc: usize) -> usize {
    let (points, rows, cols) = input;
    let emptyrows = (0..*rows).filter(|i| points.iter().all(|(x,_)| x != i)).collect();
    let emptycols = (0..*cols).filter(|j| points.iter().all(|(_,y)| y != j)).collect();

    let expanded = expand_universe(points, &emptyrows, &emptycols, inc);

    let mut sum = 0;
    for i in 0..(expanded.len()) {
        for j in (i+1)..expanded.len() {
            sum += manhattan_distance(&expanded[i], &expanded[j]);
        }   
    }
    sum
}
