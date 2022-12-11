use std::collections::HashSet;
use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("res1 {res_p1} | res2 {res_p2}");
    assert!(res_p1 == 13);
    assert!(res_p2 == 1);

    let contents = fs::read_to_string("input_test_larger.txt").expect("Failure");
    let input = parse(contents);
    let res_p2_2 = part2(&input);
    assert!(res_p2_2 == 36);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1} | expect 5874");
    println!("part 2: {res_p2} | expect 2467");
}

type Point = (i32, i32);
type Movement = (i32, Point);

fn parse(filecontent: String) -> Vec<Movement> {
    filecontent
        .lines()
        .map(|x| {
            let sp = x.split(' ').collect::<Vec<&str>>();
            let nr = sp[1].parse::<i32>().unwrap();
            match sp[0] {
                "U" => (nr, (0, 1)),
                "D" => (nr, (0, -1)),
                "R" => (nr, (1, 0)),
                "L" => (nr, (-1, 0)),
                _ => (1, (0, 0)),
            }
        })
        .collect()
}

fn touching(a: Point, b: Point) -> bool {
    (a.0 - b.0).abs() < 2 && (a.1 - b.1).abs() < 2
}

fn same_line(a: Point, b: Point) -> bool {
    a.0 == b.0 || a.1 == b.1
}

fn mov_sameline(h: Point, t: Point) -> Point {
    if h.0 > t.0 {
        return (1, 0);
    }
    if h.0 < t.0 {
        return (-1, 0);
    }
    if h.1 > t.1 {
        return (0, 1);
    }
    if h.1 < t.1 {
        return (0, -1);
    }
    (0, 0)
}

fn mov_diag(h: Point, t: Point) -> Point {
    let x = {
        if h.0 > t.0 {
            1
        } else {
            -1
        }
    };
    let y = {
        if h.1 > t.1 {
            1
        } else {
            -1
        }
    };
    (x, y)
}

fn solve_snake_moves(movs: &[Movement], snake_len: usize) -> usize {
    let mut snake: Vec<Point> = Vec::new();
    (0..snake_len).for_each(|_| snake.push((0, 0)));
    let mut visited: HashSet<Point> = HashSet::new();
    for (t, mov) in movs {
        (0..*t).for_each(|_| {
            snake[0].0 += mov.0;
            snake[0].1 += mov.1;
            for i in 0..snake.len() - 1 {
                if !touching(snake[i], snake[i + 1]) {
                    let movv: Point = if same_line(snake[i], snake[i + 1]) {
                        mov_sameline(snake[i], snake[i + 1])
                    } else {
                        mov_diag(snake[i], snake[i + 1])
                    };
                    snake[i + 1].0 += movv.0;
                    snake[i + 1].1 += movv.1;
                }
            }
            visited.insert(snake[snake.len() - 1]);
        })
    }
    visited.len()
}

fn part1(movs: &[Movement]) -> usize {
    solve_snake_moves(movs, 2)
    
}

fn part2(movs: &[Movement]) -> usize {
    solve_snake_moves(movs, 10)
}
