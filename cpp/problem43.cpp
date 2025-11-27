/**
 * Feeling like a a bit of brute forcing here to really stretch the 
 * optimizations a bit as the last pandigital problem was way too quick to compute.
 * 
 * 
 * Now, if you weren't solving this the idiotic way, you'd be looking
 * to throw away some permutations with divisibility rules.
 * 
 * 2 and 5 are the easiest by far, since it means your d4 is even
 * and d6 is 0 or 5. Poof, that's 90% of the domain gone right there.
 * 
 * There might be some absolutely vile things when you combine rules too,
 * like figuring out what possible remainders multiples of 13 have mod 17,
 * then figuring out how that changes when you do x % 100 * 10 + d10.
 * 
 * I'm not in the mood for that though. Let's smash our way through it.
 */

#include <cstdint>
#include <algorithm>
#include <iostream>

using namespace std;

int divisors[] = {2,3,5,7,11,13,17};

/**
 * You could potentially make this even more disgusting by
 * hand unrolling the loop and optimising the divisibility rules
 * rather than doing 2 multiplies, 3 adds and a mod for each one.
 * 
 * Not quite that desperate yet though.
 */
inline bool is_substring_divisible(const int (&digits)[10]) {
    int next = digits[1] * 100 + digits[2] * 10 + digits[3];
    for(int i = 0; i < 7; ++i) {
        if(next % divisors[i] != 0) {
            return false;
        }
        next = (next % 100) * 10 + digits[i + 4];
    }
    return true;
}

inline int64_t to_number(const int (&digits)[10]) {
    int64_t result = 0;
    for(int i = 0; i < 10; ++i) {
        result = result * 10 + digits[i];
    }
    return result;
}

int main() {
    // I did just realise the problem never clarifies if a leading zero
    // is allowed or not. It feels more correct to not allow it, so let's do that.
    int current_permutation[10] = {1,0,2,3,4,5,6,7,8,9};

    int64_t sum = 0;
    do {
        if(is_substring_divisible(current_permutation)) {
            sum += to_number(current_permutation);
        }
    } while (next_permutation(current_permutation, current_permutation + 10));

    // On my machine, 95 milliseconds. I guess we need a bigger brute force
    // next time.

    cout << sum << endl;

    return 0;
}