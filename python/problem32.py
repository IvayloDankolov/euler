"""
Right, this is absolutely getting brute forced.

Let's define some limits though. Clearly all 9 digits can't go into the 
product, or even 7 digits since 9*8 is not a seven digit number.
I know, dropping some profound mathematical facts right there.

97 * 86 is also 4 digits, so it seems 4 digit products are all we can realistically reach

3 giti products are easy to rule out as well:
123 * 456 = 56088 (5 digits)
1345 * 26 = 34970 (5 digits)
23456 * 1 you'll be surprised to learn is also 5 digits.

So a so called 'pandigital' product must be exactly 4 digits.

The only way we would be able to produce it is either with a 1 digit * 4 digit
or 2 digit * 3 digit multiplicand/multiplier.

That means rather than bothering with permutations, we can just do this:
"""

digits = set('123456789')

def is_pandigital(fragments):
    combined = ''.join(str(fragment) for fragment in fragments)
    return len(combined) == 9 and set(combined) == digits


def is_pandigital_product(n):
    return any(is_pandigital([a, n//a, n]) for a in range(1, 100) if n % a == 0)

all_pandigital_products = (n for n in range(1000, 10000) if is_pandigital_product(n))
    
print(sum(all_pandigital_products))