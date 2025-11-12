use std::fs::File;
use std::io::{self, BufRead};

fn read_names(path: &str) -> Vec<String> {
    let file = File::open(path).expect("Unable to open file");
    let reader = io::BufReader::new(file);
    reader.split(b',')
        .map(|bytes| {
            let s = String::from_utf8(bytes.expect("Cannot read fragment")).expect("Invalid UTF-8");
            s.trim_matches('"').to_string()
        })
        .collect()
}

fn name_value(name: &str) -> u32 {
    name.chars()
        .map(|c| (c as u8 - b'A' + 1) as u32)
        .sum()
}

fn name_score(name: &str, position: u32) -> u32 {
    name_value(name) * (position + 1)
}

fn main() {
    let mut names = read_names("problem22_input.txt");
    names.sort();
    let total_score: u32 = names.iter().enumerate()
        .map(|(i, name)| name_score(name, i as u32))
        .sum();
    println!("{}", total_score);
}