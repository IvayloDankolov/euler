#include <vector>
#include <iostream>

#include "utils.cpp"

int quadratic_consec_primes(int a, int b, const std::vector<bool>& is_prime) {
    /*
    (n+1) ^ 2 + a * (n+1) + b = n^2 + 2n + 1 + a*n + a + b
        = n^2 + a*n + b + 2n + a + 1
        = P(n) + 2n + a + 1

    Thus we can compute it recursively. Does it make any sense to do so? Not really, but it's a fun fact.
    */
    int n = 0;
    int fn = b;
    while(is_prime[fn]) {      
        fn += 2 * n + a + 1;
        ++n;
    }
    return n;
}

int main() {

    int total_primes = 6 * 1000000; // I don't think we'll need quite that many but C++ goes brrr

    std::vector<bool> is_prime = prime_sieve(total_primes);

    int max_consec = 0;
    int max_a = 0;
    int max_b = 0;
    for(int a = -999; a < 1000; ++a) {
        for(int b = -1000; b <= 1000; ++b) {
            int consec = quadratic_consec_primes(a, b, is_prime);
            if(consec > max_consec) {
                max_consec = consec;
                max_a = a;
                max_b = b;
            }
        }
    }

    std::cout << "Max consecutive primes: " << max_consec << " for a = " << max_a << ", b = " << max_b << std::endl;
    std::cout << max_a * max_b << std::endl;

}