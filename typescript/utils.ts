class GrowableFloat64Array {
    private array: Float64Array;
    private length: number;

    constructor(initialSize: number) {
        this.array = new Float64Array(initialSize);
        this.length = initialSize;
    }

    get(index: number): number {
        this.growToFit(index);
        return this.array[index];
    }

    set(index: number, value: number): void {
        this.growToFit(index);
        this.array[index] = value;
    }

    private growToFit(index: number): void {
        if (index < this.length) {
            return;
        }
        let newLength = this.length;
        while (newLength <= index) {
            newLength *= 2;
        }
        const newArray = new Float64Array(newLength);
        newArray.set(this.array);
        this.array = newArray;
        this.length = newLength;
    }
}

export function memoize_integer(fn: (n: number) => number, initial_size: number): (n: number) => number {
    const cache = new GrowableFloat64Array(initial_size);
    return (n: number): number => {
        if(n < 0 || !Number.isInteger(n)) {
            throw new Error("Input must be a non-negative integer");
        }
        if (cache.get(n) === 0) {
            const val = fn(n);
            cache.set(n, val);
            return val;
        }
        return cache.get(n);
    };
    
}

export namespace Gen {

    export function* map<T, U>(gen: Generator<T>, fn: (val: T) => U): Generator<U> {
        for (let val of gen) {
            yield fn(val);
        }
    }

    export function* filter<T>(gen: Generator<T>, predicate: (val: T) => boolean): Generator<T> {
        for (let val of gen) {
            if (predicate(val)) {
                yield val;
            }
        }
    }

    export function reduce<T, U>(gen: Generator<T>, fn: (acc: U, val: T) => U, initial: U): U {
        let acc = initial;
        for (let val of gen) {
            acc = fn(acc, val);
        }
        return acc;
    }

    export function some<T>(gen: Generator<T>, predicate: (val: T) => boolean): boolean {
        for (let val of gen) {
            if (predicate(val)) {
                return true;
            }
        }
        return false;
    }

    export function sum(gen: Generator<number>): number {
        return reduce(gen, (acc, val) => acc + val, 0);
    }

    export function* range(start: number, end: number): Generator<number> {
        for (let i = start; i < end; i++) {
            yield i;
        }
    }

    export function* divisors(n: number): Generator<number> {
        if(n > 1) yield 1;
        const limit = Math.floor(Math.sqrt(n));
        for (let i of range(2, limit + 1)) {
            if (n % i === 0) {
                yield i;
                if (i !== n / i) {
                    yield n / i;
                }
            }
        }
    }
}