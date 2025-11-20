/**
 * The longest word in the input is like 14,
 * 
 * and 14 * 26 = 364, so we could totally get away with a
 * simple lookup table for constant time checks.
 * 
 * No need to even bust out sets which is slightly disappointing.
 * 
 */

 use std::fs::File;
 use std::io::{self, BufRead};

 fn trinalge_number_lookup(max_value: usize) -> Vec<bool>  {
        let mut lookup = vec![false; max_value + 1];
        let mut n = 1;
        let mut tri_num = 1;
        while tri_num <= max_value {
            lookup[tri_num] = true;
            n += 1;
            tri_num += n;
        }
        lookup
 }

 fn read_words(path: &str) -> impl Iterator<Item=String> {
    let file = File::open(path).expect("Unable to open file");
    let reader = io::BufReader::new(file);
    reader.split(b',')
        .map(|bytes| {
            let s = String::from_utf8(bytes.expect("Cannot read fragment")).expect("Invalid UTF-8");
            s.trim_matches('"').to_string()
        })
}

fn word_value(word: &str) -> usize {
    word.chars()
        .map(|c| (c as u8 - b'A' + 1) as usize)
        .sum()
}

 fn main() {
  let words = read_words("problem42_input.txt");

  let triangle_vec = trinalge_number_lookup(26 * 20); // 20 is a safe max length

  let num_triangle_words = words
      .filter(|word| triangle_vec[word_value(word)])
      .count();

  println!("Number of triangle words: {}", num_triangle_words);

 }