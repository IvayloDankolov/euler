#include <iostream>

int collatz_steps(long long n) {
	int i=0;
	for(; n != 1; ++i) {
		n = n&1 ? 3*n+1 : n>>1;
	}
	return i;
}

int main() {
	int limit; 
	std::cin >> limit;

	int max = 0;
	int maxi = 1;
	for(int i=2; i<limit; ++i) {
		int steps = collatz_steps(i);
		if(steps > max) {
			max = steps;
			maxi = i;
		}

		if(i % 10000 == 0) {
			std::cout << " For " << i << " intermediate max: " << maxi << " with steps: " << max << std::endl;
		}
	}	

	std::cout << "Max steps: " << max << " for: " << maxi << std::endl;

	return 0;
}