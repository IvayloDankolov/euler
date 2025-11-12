#include <iostream>

using std::cout;
using std::endl;

#define M 20

long long grid[M+1][M+1] = {0};

int main() {
	for(int outer=0; outer<=M; ++outer) {
		grid[outer][0] = grid[0][outer] = 1;
	}
	for(int row=1; row<=M; ++row) {
		for(int col=1; col<=M; ++col) {
			grid[row][col] = grid[row-1][col] + grid[row][col-1];
		}
	}

	cout << grid[M][M] << endl;
}

