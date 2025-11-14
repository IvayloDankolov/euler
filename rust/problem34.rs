/*
 Like a similar earlier porblem, observe we're adding finite things here.

 Largest being 9! = 362880

 8 of those is a 7 digit number, so there's no possible way an
 8+ digit number can be equal to the sum of the factorials

 What's that, do I hear the sweet sound of brute forcing? Yep.
 */

 fn factorial(n: u32) -> u32 {
     (1..=n).product()
 }

 fn digits_factorial_sum(mut n: u32) -> u32 {
     let mut sum = 0;
     while n > 0 {
         let digit = n % 10;
         sum += factorial(digit);
         n /= 10;
     }
     sum
 }

 fn is_curious_number(n: u32) -> bool {
     n == digits_factorial_sum(n)
 }

 fn main() {
    let  max_number:u32 = factorial(9) * 7;

    let answer = (10..=max_number)
        .filter(|&n| is_curious_number(n))
        .sum::<u32>();

    println!("{}", answer);
 }

