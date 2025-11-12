#import <iostream>
#import <vector>
#import <sstream>
#import <fstream>
#import <algorithm>


using namespace std;

int main() {
	vector<vector<int> > triangle;

	ifstream input("problem18_triangle.txt");

	while(!input.eof()) {
		string line;
		getline(input, line);

		vector<int> res;
		istringstream stream(line);
		while(!stream.eof()) {
			int i;
			stream >> i;
			res.push_back(i);
		}

		triangle.push_back(res);
	}

	auto rowsCount = triangle.size();

	vector<vector<int> > max_distances;
	max_distances.push_back(triangle[rowsCount-1]);

	for(int i = rowsCount-2, outIdx=1; i>=0; --i, ++outIdx) {
		auto row = triangle[i];
		auto currentRowSize = row.size();
		auto distancesSoFar = max_distances[outIdx-1];
		vector<int> newMaxDistances;

		for(int elIdx = 0; elIdx < currentRowSize; ++elIdx) {
			newMaxDistances.push_back(row[elIdx] + max(distancesSoFar[elIdx], distancesSoFar[elIdx + 1]));
		}
		max_distances.push_back(newMaxDistances);
	}

	cout << max_distances[max_distances.size()-1][0] << endl;

	return 0;
}