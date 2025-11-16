#include "utils.cpp"
#include <iostream>

const int TOTAL_PRIMERS = 1000000;

bool is_circular_prime(int n, PrimeSieve& primes) {
    int digits = floor(log10(n)) + 1;
    int firstDigitMultiplier = pow(10, digits - 1);
    int curr = n;
    do {
        if(!primes.check(curr)) {
            return false;
        }
        /*
        * NB: This doesn't actually work if your number includes a zero.
        * Fun fact, though, a circular prime cannot contain a zero.
        * Pretty trivial to prove - eventually you have to rotate the zero
        * to the last position, and, well, that ain't a prime.
        */
        int trailing = curr % 10;
        curr = (curr / 10) + (trailing * firstDigitMultiplier);
    } while (curr != n);
    return true;
}

int main() {
    auto primes = PrimeSieve(TOTAL_PRIMERS);

    int count = 0;
    for(int i = 2; i < TOTAL_PRIMERS; ++i) {
        if(is_circular_prime(i, primes)) {
            ++count;
        }
    }

    std::cout << count << std::endl;
    return 0;
}