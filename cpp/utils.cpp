#include <vector>

int MIN_SIEVE_SIZE = 1000000;

class PrimeSieve
{
private:
    std::vector<bool> is_prime;

    void extend_sieve(int new_size)
    {
        if (new_size <= is_prime.size())
        {
            return;
        }
        new_size = std::max(new_size, MIN_SIEVE_SIZE);
        int current_size = is_prime.size();
        is_prime.resize(new_size, true);

        is_prime[0] = is_prime[1] = false;


        for (int i = 2; 2 * i < new_size; ++i)
        {
            if (!is_prime[i])
            {
                continue;
            }
            int start = std::max(current_size - (current_size % i) + i, i * 2);
            for (int j = start; j < new_size; j += i)
            {
                is_prime[j] = false;
            }
        }
    }

public:
    PrimeSieve(int initial_size = MIN_SIEVE_SIZE)
    {
        is_prime = std::vector<bool>();
        extend_sieve(initial_size);
    }

    bool check(int n) {
        if(n >= is_prime.size()) {
            extend_sieve(n * 2);
        }
        return is_prime[n];
    }
};