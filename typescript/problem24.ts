import { factorial } from "./math";

// Note: this assumes unique elements
// 
// Could you do this in both linear time and space with in place array shuffles?
// Yes, absolutely. Do I care in the slightest? No.
// Have to implement it with bigints anyway if you're permuting a million elements.
function nthPermutation<T>(elements: T[], n: number): T[] {
    if(elements.length === 0) {
        return [];
    }
    
    const alphabetSize = elements.length;
    const totalPermutations = factorial(alphabetSize);

    if (n < 0 || n >= totalPermutations) {
        throw new Error(`n must be in range [0, ${totalPermutations - 1}]`);
    }

    if (elements.length === 1) {
        return elements;
    }

    const bucketSize = (totalPermutations / alphabetSize);
    const firstLetterIndex = Math.floor(n / bucketSize);
    const subIndex = n % bucketSize;

    return [
        elements[firstLetterIndex],
        ...nthPermutation(
            elements.filter((_, index) => index !== firstLetterIndex),
            subIndex
        )
    ];

}

const alphabet = '0123456789'.split('');

const DESIRED_PERMUTATION_INDEX = 1000000 - 1; // zero-based index

console.log(nthPermutation(alphabet, DESIRED_PERMUTATION_INDEX).join(''));
    