import { Num } from "./math";
import { Gen } from "./utils";

const INPUT = 10000;

const allAmicable = Gen.filter(Gen.range(1, INPUT), Num.isAmicable);

console.log(Gen.sum(allAmicable));
