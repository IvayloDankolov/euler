function* range(from, to, step=1) {
	if(step > 0) {
		while(from < to) {
			yield from;
			from += step;
		}
	} else {
		while(from > to) {
			yield from;
			from += step;
		}
	}
}

const lows = [
	'', 'one', 'two', 'three', 'four', 'five', 
	'six', 'seven', 'eight', 'nine', 'ten',
	'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen',
	'sixteen', 'seventeen', 'eighteen', 'nineteen',
];
const tens = [
	'', 'ten', 'twenty', 'thirty', 'forty',
	'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
];

const lowsLen = lows.map(s => s.length);
const tensLen = tens.map(s => s.length);

const hundredsPatternLen = 'hundred'.length;
const hundredsLen = [0, ...[...range(1, 10)].map(h => lowsLen[h] + hundredsPatternLen)];

function letterCount(n) {
	if(n >= 100) {
		const remainder = letterCount(n%100);
		return hundredsLen[Math.floor(n / 100)] + (remainder > 0 ? remainder + 3 : 0);
	} else if(n >= 20) {
		return tensLen[Math.floor(n/10)] + lowsLen[n%10];
	} else {
		return lowsLen[n];
	}
}

console.log([...range(1, 1000)].map(letterCount).reduce((a, b) => a+b, 0) + 11);