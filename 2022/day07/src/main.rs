use std::collections::HashMap;
use std::fmt::Debug;
use std::fs;
use std::str::FromStr;

use onig::{Captures, Regex};

#[test]
fn tests() {
    let contents = fs::read_to_string("input_test.txt").expect("Failure");
    let input: Vec<String> = parse(contents);
    let input_parsed: FileSystem = parse_as_directory(input);
    let res_p1 = part1(&input_parsed);
    let res_p2 = part2(&input_parsed);
    assert!(res_p1 == 95437);
    assert!(res_p2 == 24933642);
}

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Failure");
    let input: Vec<String> = parse(contents);
    let dir = parse_as_directory(input);
    let res_p1 = part1(&dir);
    let res_p2 = part2(&dir);
    println!("part 1: {res_p1} | should be 2061777");
    println!("part 2: {res_p2} | should be 4473403");
}

#[derive(Debug)]
enum FS {
    File(u32),
    Directory(HashMap<String, FS>),
}

type FileSystem = HashMap<String, FS>;

// parsing
// ----------

fn parse_as_directory(instructions: Vec<String>) -> FileSystem {
    let mut directory: FileSystem = HashMap::new();
    fn process(dir: &mut FileSystem, instructions: &Vec<String>, ic: usize) -> usize {
        let reg_dir = Regex::new(r"dir (\w+)").unwrap();
        let reg_file = Regex::new(r"(\d+) ([\w|\.]+)").unwrap();
        let reg_cd = Regex::new(r"cd (\w+)").unwrap();

        let mut ic = ic;
        loop {
            if ic >= instructions.len() {
                break;
            }
            let inst = instructions.get(ic).unwrap();
            if inst.starts_with('$') {
                match inst.as_str() {
                    "$ cd .." => {
                        return ic; // step back
                    }
                    "$ cd /" => {
                        // ignore because it happens only once... otherwise I need to step back until I get to the root
                    }
                    "$ ls" => {
                        // do nothing, just listing
                    }
                    _ => {
                        let dir_deep = get_at::<String>(&reg_cd.captures(inst).unwrap(), 1);
                        match dir.get_mut(&dir_deep).unwrap() {
                            FS::Directory(new_dir) => {
                                ic = process(new_dir, instructions, ic + 1);
                            }
                            FS::File(_) => {}
                        }
                    }
                }
            } else {
                if reg_dir.is_match(inst) {
                    let direct = get_at::<String>(&reg_dir.captures(inst).unwrap(), 1);
                    dir.insert(direct, FS::Directory(HashMap::new()));
                }
                if reg_file.is_match(inst) {
                    let file = reg_file.captures(inst).unwrap();
                    let filename = get_at::<String>(&file, 2);
                    let size = get_at::<u32>(&file, 1);
                    dir.insert(filename, FS::File(size));
                }
            }
            ic += 1;
        }

        ic
    }

    process(&mut directory, &instructions, 0);
    directory
}

fn get_at<U: FromStr + Debug>(cap: &Captures, i: usize) -> U
where
    U: FromStr + Debug,
    <U as FromStr>::Err: Debug,
{
    cap.at(i).unwrap().parse::<U>().unwrap()
}

fn parse<T>(filecontent: String) -> Vec<T>
where
    T: FromStr + Debug,
    <T as FromStr>::Err: Debug,
{
    filecontent
        .lines()
        .map(|x| x.parse::<T>().unwrap())
        .collect()
}

// solutions
// -----------

fn dir_size(dir: &FileSystem) -> Vec<u32> {
    let mut my_sum: u32 = 0;
    let mut vec: Vec<u32> = Vec::new();
    dir.values().for_each(|d| match d {
        FS::Directory(d) => {
            vec.append(&mut dir_size(d));
            my_sum += vec.last().unwrap();
        }
        FS::File(size) => my_sum += size,
    });
    vec.push(my_sum);
    vec
}

fn part1(fs: &FileSystem) -> u32 {
    let sizes = dir_size(fs);
    sizes.iter().filter(|x| **x < 100_000).sum()
}

fn part2(fs: &FileSystem) -> u32 {
    let sizes = dir_size(fs);
    let need_free = 30_000_000 - (70_000_000 - sizes.last().unwrap());
    *sizes.iter().filter(|x| **x >= need_free).min().unwrap()
}
