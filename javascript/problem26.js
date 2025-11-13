/*
If you look at the first few fractions:

1/2 = 0.5
1/3 = 0.(3)
1/4 = 0.25
1/5 = 0.2
1/6 = 0.1(6)
1/7 = 0.(142857)
1/8 = 0.125
1/9 = 0.(1)
1/10 = 0.1

What immediately jumps out about the cycle of 1/7 is that it's 6 digits. Which other than being one less than 7,
also happens to be how many non-zero remainders there are mod 7

Since long division is basically take the remainder and multiply by 10 until it fits, I 
suspect but I'm not going to formally prove depends on how long 10^n, n=0.. takes to cycle back to 1

Seems to hold for 11: 1 -> 10 -> 1 (9*99 + 1) and the fraction cycle is 1/11 = 0.(09)

Also note for numbers that contain multiples of the base, those multiples do not increase the cycle length at all

And finally if the number is only made up of the base's prime factors, there is no cycle
*/

function fractionCycleLength(d) {
    while(d % 2 === 0) d /= 2;
    while(d % 5 === 0) d /= 5;
    if (d === 1) return 0;
    
    let remainder = 1;
    let length = 0;
    do {
        remainder = (remainder * 10) % d;
        length++;
    } while (remainder !== 1);
    return length;
}

const integers = new Array(1000).fill(0).map((_, i) => i + 1);

const maxCycle = integers.map(d => [d, fractionCycleLength(d)])
    .reduce((a, b) => a[1] >= b[1] ? a : b);
    
console.log(maxCycle);