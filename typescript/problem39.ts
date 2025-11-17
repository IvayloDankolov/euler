/**
 * This really isn't interesting enough to not just brute force.
 * You could be a bit more clever in generating triplets,
 * 
 * but I think the best you can probly do is O(n sqrt(n)) or so
 * by precomputing squares and iterating over adding squares to a^2 to get a
 * square again. Under a thousand you're not going to see any speed
 * difference from the naive n^2.
 * 
 * Also, at this point I'm basically rolling out my own little iterator library.
 * I'm surprised there still isn't one of these that's on the level of
 * lodash in popularity.
 * 
 */
import { It } from "./utils";

type Triplet = [number, number, number];

function* pythagoreanTriples(aLimit: number, bLimit: number): Generator<Triplet> {
    for (let a = 1; a <= aLimit; a++) {
        for (let b = a; b <= bLimit; b++) {
            const cSquared = a * a + b * b;
            const c = Math.sqrt(cSquared);
            if (Number.isInteger(c)) {
                yield [a, b, c];
            }
        }
    }
}

function perimeter(sides: Triplet): number {
    return sides[0] + sides[1] + sides[2];
}

function findMaximalPerimeterCount(limit: number): number {
    const perimeterCounts: Map<number, number> = new Map();

    // Even this is not a very tight upper bound,
    // but we're not dealing with especially large numbers here.
    const tupleUpperBound = Math.floor(limit / 2);
    for (const triplet of pythagoreanTriples(tupleUpperBound, tupleUpperBound)) {
        const p = perimeter(triplet);
        if (p <= limit) {
            perimeterCounts.set(p, (perimeterCounts.get(p) ?? 0) + 1);
        }
    }

    return It.maxBy(perimeterCounts.entries(), ([_, count]) => count)?.[0] ?? -1;
}

console.log(findMaximalPerimeterCount(1000));