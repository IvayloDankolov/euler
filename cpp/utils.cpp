#include <vector>


std::vector<bool> prime_sieve(int total) {
    std::vector<bool> is_prime(total + 1, true);

    is_prime[0] = false;
    is_prime[1] = false;

    for (int i = 2; 2 * i <= total; ++i) {
        if (is_prime[i]) {
            for (int j = 2 * i; j <= total; j += i) {
                is_prime[j] = false;
            }
        }
    }
    
    return is_prime;
}