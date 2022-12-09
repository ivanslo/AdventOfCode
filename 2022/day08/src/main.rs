use numrs::{common::Number, matrix::Matrix};
use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Matrix<i8> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 21);
    assert!(res_p2 == 8);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Matrix<i8> = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    println!("part 1: {res_p1}");
    println!("part 2: {res_p2}");
}

// helper
fn _print_matrix<T: Number + std::fmt::Display>(matrix: &Matrix<T>) {
    println!("Size = {}x{}", matrix.num_rows(), matrix.num_cols());
    for i in 0..matrix.num_rows() {
        for j in 0..matrix.num_cols() {
            print!("{} ", matrix.get(i, j))
        }
        println!("");
    }
}

fn parse(filecontent: String) -> Matrix<i8> {
    let lines: Vec<String> = filecontent.lines().map(|l| l.to_string()).collect();
    let m = lines.len();
    let n = lines[0].as_bytes().len();
    let mut matr: Matrix<i8> = Matrix::new(m, n, 0);

    for (i, line) in lines.iter().enumerate() {
        for (j, ch) in line.chars().into_iter().enumerate() {
            let c: i8 = ch.to_digit(10).unwrap() as i8;
            matr.set(i, j, c)
        }
    }

    matr
}

fn part1(ns: &Matrix<i8>) -> u32 {
    let mut v: Matrix<i8> = Matrix::new(ns.num_rows(), ns.num_cols(), 0);

    let rows = ns.num_rows();
    let cols = ns.num_cols();
    for i in 0..rows {
        let mut max_left = -1;
        let mut max_right = -1;
        let mut max_top = -1;
        let mut max_bottom = -1;
        for j in 0..cols {
            if ns.get(i, j) > max_left {
                v.set(i, j, v.get(i, j) | 1);
                max_left = ns.get(i, j);
            }
            if ns.get(i, cols - 1 - j) > max_right {
                v.set(i, cols - 1 - j, v.get(i, cols - 1 - j) | 1);
                max_right = ns.get(i, cols - 1 - j);
            }
            if ns.get(j, i) > max_top {
                v.set(j, i, v.get(j, i) | 1);
                max_top = ns.get(j, i);
            }
            if ns.get(cols - 1 - j, i) > max_bottom {
                v.set(cols - 1 - j, i, v.get(cols - 1 - j, i) | 1);
                max_bottom = ns.get(cols - 1 - j, i);
            }
        }
    }
    v.get_vec().into_iter().filter(|x| *x == 1).count() as u32
}

fn part2(ns: &Matrix<i8>) -> u32 {
    let rows = ns.num_rows();
    let cols = ns.num_cols();

    let mut dist: Matrix<u32> = Matrix::new(ns.num_rows(), ns.num_cols(), 0);
    for i in 0..rows {
        for j in 0..cols {
            let mut l = 0;
            let mut r = 0;
            let mut u = 0;
            let mut d = 0;

            loop {
                l += 1;
                if l > j {
                    l -= 1;
                    break;
                }
                if ns.get(i, j - l) >= ns.get(i, j) {
                    break;
                }
            }
            loop {
                r += 1;
                if r + j >= cols {
                    r -= 1;
                    break;
                }
                if ns.get(i, j + r) >= ns.get(i, j) {
                    break;
                }
            }
            loop {
                u += 1;
                if u > i {
                    u -= 1;
                    break;
                }
                if ns.get(i - u, j) >= ns.get(i, j) {
                    break;
                }
            }
            loop {
                d += 1;
                if d + i >= rows {
                    d -= 1;
                    break;
                }
                if ns.get(i + d, j) >= ns.get(i, j) {
                    break;
                }
            }
            dist.set(i, j, (r * l * d * u).try_into().unwrap());
        }
    }
    *dist.get_vec().iter().max().unwrap()
}
