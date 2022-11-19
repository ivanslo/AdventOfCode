use core::iter::zip;
use std::fs;

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("cannot read the file");
    let input = parse(contents);
    let res_p1 = part1(&input);
    let res_p2 = part2(&input);
    assert!(res_p1 == 7);
    assert!(res_p2 == 5);
}

fn main() {
    {
        let contents = fs::read_to_string("input.txt").expect("cannot read the file");
        let input = parse(contents);
        let res_p1 = part1(&input);
        let res_p2 = part2(&input);
        println!("part 1: {res_p1}");
        println!("part 2: {res_p2}");
    }
}

fn parse(filecontent: String) -> Vec<u32> {
    filecontent
        .lines()
        .map(|x| x.parse::<u32>().unwrap())
        .collect()
}

fn part1(numbers: &Vec<u32>) -> u32 {
    zip(&numbers[..], &numbers[1..])
        .filter(|(a, b)| *a < *b)
        .count() as u32
}

fn part2(numbers: &Vec<u32>) -> u32 {
    let sums = zip(zip(&numbers[..], &numbers[1..]), &numbers[2..]).map(|((a, b), c)| *a + *b + *c);

    let mut count = 0;
    let mut previous: u32 = 0;

    for sum in sums {
        if sum > previous {
            count += 1
        }
        previous = sum
    }
    count - 1
    // let mut count = 0;
    // for (i, _) in numbers[..numbers.len() - 3].iter().enumerate() {
    //     let sum1: u32 = numbers[i..i + 3].iter().sum();
    //     let sum2: u32 = numbers[i + 1..i + 4].iter().sum();
    //     if sum1 < sum2 {
    //         count = count + 1
    //     }
    // }
    // count
}
