def fact(n):
    return 1 if n == 0 else n * fact(n-1)

def sum_digits(n):
    return sum(int(d) for d in str(n))

print(sum_digits(fact(100)))