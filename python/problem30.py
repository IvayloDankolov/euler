"""
This seems like it would be extremely hard
to actually come up with a closed form solution for,
if at all possible. So let's just brute force it.

In terms of limit, it's obvious we can't have more than a 6 digit,
since 7 * 9^5 is 6 digits, not 7.
"""

import math

def digit_fifth_power_sum(n: int) -> int:
    return sum(int(digit) ** 5 for digit in str(n))

upper_limit = 6 * (9 ** 5)

result = sum(n for n in range(10, upper_limit) if digit_fifth_power_sum(n) == n)

print(result)