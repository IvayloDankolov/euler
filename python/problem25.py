import math

def fib(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a

"""

phi = (1 + math.sqrt(5)) / 2
psi = (1 - math.sqrt(5)) / 2

Fib(n) = phi^n / sqrt(5) - psi^n / sqrt(5)

Fib_digits(n) = floor(log10(Fib(n))) + 1
               = floor(log10(phi^n / sqrt(5) - psi^n / sqrt(5))) + 1
               = floor(log10(phi^n / sqrt(5))) + 1 // |psi^n / sqrt(5)| < 1 for n >= 1
               = floor(n * log10(phi) - log10(sqrt(5))) + 1

Yes, I just did math in python comments, sue me.
"""
def num_digits_nth_fib(n: int) -> int:
    if n == 1:
        return 1
    phi = (1 + math.sqrt(5)) / 2
    return math.floor(n * math.log10(phi) - math.log10(math.sqrt(5))) + 1


target_digits = 1000

target_fib = next(n for n in range(1, 10000) if num_digits_nth_fib(n) >= target_digits)

print(target_fib)