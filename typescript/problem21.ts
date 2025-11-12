import { Gen, memoize_integer } from "./utils";

function sumOfDivisors(n: number): number {
    const ds = Gen.divisors(n);
    return Gen.sum(ds);
}

const memoSOD = memoize_integer(sumOfDivisors, 1024);

function isAmicable(n: number): boolean {
    const neighbor = memoSOD(n);
    return neighbor !== n && memoSOD(neighbor) === n;
}

const INPUT = 10000;

const allAmicable = Gen.filter(Gen.range(1, INPUT), isAmicable);

console.log(Gen.sum(allAmicable));
