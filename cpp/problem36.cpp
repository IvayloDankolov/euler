/*
* Now, in theory you could do something fancy here
* like generating palindromes rather than brute forcing and doing a set intersection.
*
* Is there any chance in hell that outperforms a linear time brute force at under 1 million?
* Not in the slightest.
*/

#include <iostream>

inline bool is_palindrome(int n, int base) {
    int reversed = 0;
    int original = n;
    while (n > 0) {
        reversed = reversed * base + n % base;
        n /= base;
    }
    return original == reversed;
}

int main() {
    int sum = 0;
    for (int i = 1; i < 1000000; ++i) {
        if (is_palindrome(i, 10) && is_palindrome(i, 2)) {
            sum += i;
        }
    }
    std::cout << sum << std::endl;
    return 0;
}