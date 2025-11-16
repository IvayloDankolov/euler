/*
I can probably make a pretty reasonable guess at what the upper
bound is for this, but I'm just going to write a resizable sieve instead.

Oh and I haven't really commented on this perviously,
but yes, you can totally include cpp files in other cpp files.
IF you thought the language would stop you from doing dumb crap like that,
maybe go back to Rust.

In all seriousness, the nice thing about this is it lets me just compile
e.g. problem37.cpp without a make system or include paths.
*/

#include "utils.cpp"
#include <iostream>

bool is_consecutive_prime_suffix(int n, PrimeSieve& primes) {
    if(n < 10) {
        return false;
    }
    while(n > 0) {
        if(!primes.check(n)) {
            return false;
        }
        n /= 10;
    }
    return true;
}

bool is_consecutive_prime_prefix(int n, PrimeSieve& primes) {
    if(n < 10) {
        return false;
    }
    
    int digits = floor(log10(n)) + 1;
    int firstDigitMultiplier = pow(10, digits - 1);

    do {
        if(!primes.check(n)) {
            return false;
        }
        n = n % firstDigitMultiplier; // Remove first digit
        firstDigitMultiplier /= 10;
    } while (n > 0);
    return true;
}
    
bool is_truncatable_prime(int n, PrimeSieve& primes) {
    return is_consecutive_prime_suffix(n, primes) && is_consecutive_prime_prefix(n, primes);
}

const int TOTAL_TRUNCATABLE_PRIMES = 11;

int main() {
    auto primes = PrimeSieve();

    int found = 0;
    int sum = 0;

    int n = 10; // Single digit primes are not considered truncatable
    while(found < TOTAL_TRUNCATABLE_PRIMES) {
        if(is_truncatable_prime(n, primes)) {
            sum += n;
            ++found;

            std::cout << "Found truncatable prime: " << n << std::endl;
        }
        ++n;
    }
    std::cout << "Sum of truncatable primes: " << sum << std::endl;
    return 0;
}