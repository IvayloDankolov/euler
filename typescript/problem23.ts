import { Num } from "./math";
import { Gen } from "./utils";

const ABUNDANT_SUM_LIMIT = 28123;

const isAbundant = [false, ...Gen.map(Gen.range(1, ABUNDANT_SUM_LIMIT), Num.isAbundant)];

const firstAbundant = isAbundant.findIndex(a => a);
    
function canBeAbundantSum(n: number) {
    return Gen.some(Gen.map(Gen.range(firstAbundant, Math.floor(n / 2) + 1), x => isAbundant[x] && isAbundant[n - x]), v => v);
}

const nonAbundantSums = Gen.filter(Gen.range(1, ABUNDANT_SUM_LIMIT + 1), n => !canBeAbundantSum(n));


console.log(Gen.sum(nonAbundantSums));