/**
 * 
 * Ah, so we finally get to the point with pandigitals where
 * it actually makes sense to generate them rather than brute forcing things.
 * 
 * Mind you about a billion long prime sieve wouldn't take
 * that long to run on the kinds of machines we have in 2025,
 * but let's do this anyway.
 * 
 * Mind you, you don't strictly speaking need next_permutation here,
 * since generating all permutations is still  O(n * n!), but 
 * it's such a classic staple that I can't help myself.
 * 
 * Also, I'm well aware it's a builtin in C++. I won't include it in my
 * own utils and use the <algorithm> one if it comes up later, 
 * but nostalgia demands we implement it at least once.
 */

 #include <iterator>

using namespace std;

// I mean yes you could theoretically implement this for every iterator
// but we're just using std::reverse in the future so let's not bother.
template <random_access_iterator It>
inline
void reverse(It start, It end) {
    --end;
    while(start < end) {
        auto temp = *start;
        *start = *end;
        *end = temp;
        ++start;
        --end;
    }
}

template <random_access_iterator It>
bool next_permutation(It start, It end) {
    if (start == end) {
        return false;
    }

    It pivot = end;
    --pivot;

    bool found = false;
    while (pivot - start > 0)
    {
        auto curr = *pivot;
        --pivot;
        if(*pivot < curr) {
            found = true;
            break;
        }
    }

    // This is the greatest permutation
    if(!found) {
        reverse(start, end);
        return false;
    }

    It greatest_succ = end - 1;
    while(*greatest_succ <= *pivot) {
        --greatest_succ;
    }

    auto temp = *pivot;
    *pivot = *greatest_succ;
    *greatest_succ = temp;

    reverse(pivot + 1, end);
    return true;
}

#include <vector>

// Rather than writing previous_permutation, we can just invert the digits.
int to_number_reversed(const vector<int>& indices) {
    int result = 0;
    int base = indices.size() + 1;
    for (int idx : indices)
    {
        int d =  base - idx;
        result = result * 10 + d;
    }
    return result;
}

bool is_prime(int n) {
    if(n <= 1) return false;
    for(int d = 2; d * d <= n; ++d) {
        if(n % d == 0) return false;
    }
    return true;
}


int check_pandigital_primes_n(int length) {
    vector<int> perm(length);
    for(int i = 0; i < length; ++i) {
        perm[i] = i + 1;
    }

    do {
        int candidate = to_number_reversed(perm);
        if(is_prime(candidate)) {
            return candidate;
        }
    } while(next_permutation(perm.begin(), perm.end()));

    return -1;
}

/**
 * Now, by simple number theory Triangle(8) = 36 is divisible by 3,
 * so are Triangle(9) = 45 and Triangle(6) = 21.
 *
 * So we can rather heavily suspect our answer is 7-digit pandigital.
 *
 * Funnily enough, starting at 9 makes 0 difference in -O3 on my machine
 * (M4 Macbook Pro)
 * Our algorithm and doing it with 0 memory allocation is just too good,
 * so it gets drowned out by runtime startup.
 */

int largest_pandigital_prime() {
    for(int length = 9; length >= 1; --length) {
        int res = check_pandigital_primes_n(length);
        if(res != -1) {
            return res;
        }
    }
    return -1;
}



#include <iostream>
int main() {
    cout << largest_pandigital_prime() << endl;
}