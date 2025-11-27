"""
Now, we could theoretically try to express this as a system of equasions

Pj + Pk = Pa
Pj - Pk = Pb

Where j, k, a, b are all integers, j > k

Or

Pj = 1/2 (Pa + Pb)
Pk = 1/2 (Pa - Pb)


Before we expand and try and do closed form solutions or throw it into
a solver, let's observe some patterns.

From the above alternate forms, it's easy to see that the original
pentagonal numbers and their derived ones have a two way relationship.

And the derived ones not only have to add to an even number, since everything here
is integers, but to double a pentagonal number.

So when is a pentagonal number even?

n (3n-1) / 2 = 2m
3n^2 - n = 4m
3n^2 - n = 0 (mod 4)

Variants:
n = 0 (mod 4) => n^2 = 0 (mod 4) => (3n^2 - n) mod 4 = (3 * 0 - 0) mod 4 = 0 mod 4
n = 1 (mod 4) => n^2 = 1 (mod 4) => (3n^2 - n) mod 4 = (3 * 1 - 1) mod 4 = 2 mod 4
n = 2 (mod 4) => n^2 = 0 (mod 4) => (3n^2 - n) mod 4 = (3 * 0 - 2) mod 4 = 2 mod 4
n = 3 (mod 4) => n^2 = 1 (mod 4) => (3n^2 - n) mod 4 = (3 * 1 - 3) mod 4 = 0 mod 4

So we alternate 2 even 2 odd


On another note, we can pretty much ignore 1 here as the difference between pentagonal numbers
is always more than 1.

In fact, since the difference grows linearly, we can check how low the 
lowest number here has to be to possibly be involved in a sum like that

(n+1) (3n+3-1) / 2 - n(3n-1) /2 = 

(3n^2 +3n -n + 3n 3 - 1 - 3n^2 + n) / 2 = 
(6n + 2) / 2 = 2n + 1
3n + 1 > a
n > (a-1) / 3 // and we can floor that since we only care about integers

Testing that for 12, n > 3, and indeed for 4 and 5, 35 - 22 = 13 > 12

That's conveniently a pretty good bound for a brute force. Hmm...

Yeah, fuck it, why not

"""

def pentagon(n):
    return n * (3 *n - 1) // 2

# Will we find it below 9999 ? We'll see
pentagon_nums = set(pentagon(n) for n in range(1, 10000))

for j in range(1, 10000):
    Pj = pentagon(j)
    limit = (Pj - 1) // 3
    if j + 1 > limit:
        continue;
    for k in range(j+1, limit+1):
        Pk = pentagon(k)
        if (Pk - Pj) in pentagon_nums and (Pk + Pj) in pentagon_nums:
            print(Pk-Pj)
            exit(0)

print("Increase limits buddy")
