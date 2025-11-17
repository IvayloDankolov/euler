/**
 * This one at least tickles me enough to not brute force entirely.
 * 
 * Should be pretty easy to figure out which integer we're inside given the position.
 * 
 * It's a pretty obvious fact that there are 9 single digit numbers,
 * 90 double digit numbers, 900 triple digit numbers, etc.
 * 
 * So the 2 digit numbers start at position 9 + 1 (1-based)
 * 3 digit numbers start at position 9 + 90 * 2 + 1 (1-based)
 * n digit numbers at position 9 + 90 * 2 + 900 * 3 + ... + 9 * 10^(n-2) * (n-1) + 1 (1-based)
 * 
 * Now, I'm sure someone on OEIS has figured out the closed form solution,
 * but for us this is enough.
 * 
 * Lets us drop it to O(log(position))
 */

import { It } from "./utils";

function champernowneDigit(position: number): number {
    let digitCount = 1;
    let numbersInRange = 9;
    let digitsInRange = digitCount * numbersInRange;

    while (position - digitsInRange > 0) {
        position -= digitsInRange;
        digitCount++;
        numbersInRange *= 10;
        digitsInRange = digitCount * numbersInRange;
    }

    const index = Math.ceil(position / digitCount);
    const positionInNumber = ((position - 1) % digitCount);

    const number = (10 ** (digitCount - 1)) + (index - 1);
    const digit = Number(number.toString()[positionInNumber]);
    return digit;
}

const desiredPositions = [1, 10, 100, 1000, 10000, 100000, 1000000];

console.log(It.product(desiredPositions.map(champernowneDigit)));