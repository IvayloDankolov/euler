import { Gen, memoize_integer } from "./utils";

const INITIAL_BUFFER_SIZE = 10000;

export namespace Num {

    export const sumOfDivisors = memoize_integer((n: number) => {
        const ds = Gen.divisors(n);
        return Gen.sum(ds);
    }, INITIAL_BUFFER_SIZE);

    export function isAmicable(n: number): boolean {
        const neighbor = sumOfDivisors(n);
        return neighbor !== n && sumOfDivisors(neighbor) === n;
    }

    export function isAbundant(n: number): boolean {
        return sumOfDivisors(n) > n;
    }

    export function isPerfect(n: number): boolean {
        return sumOfDivisors(n) === n;
    }

    export function isDeficient(n: number): boolean {
        return sumOfDivisors(n) < n;
    }

}