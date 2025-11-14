/*
I mean, this is the most classic dynamic programming problem ever.

It's only appropriate we do it in C++.
*/

#include <iostream>

const int denominations[] = {1, 2, 5, 10, 20, 50, 100, 200};
const int num_denominations = sizeof(denominations) / sizeof(denominations[0]);

const int TARGET = 200;

int main() {
    // The only complication is coins are not unique
    // We can\t count 1p + 2p as different from 2p + 1p
    // So we need to build it up recursively in denomination order,
    // using only lower denomination coins in the combination count

    int ways[TARGET + 1][num_denominations] = {0};
    for(int d = 0; d < num_denominations; ++d) {
        // You could think of this as the only way to make 0p is to use no coins
        // But what it is really is just the base case so we don't have to constantly do bounds checking
        ways[0][d] = 1; 
    }

    for(int amount = 1; amount <= TARGET; ++amount) {
        for(int d = 0; d < num_denominations; ++d) {
            int coin_value = denominations[d];
            if(coin_value > amount) {
                break;
            }
            ways[amount][d] = amount % coin_value == 0 ? 1 : 0; // The "all this denomination" way
            if(d > 0) {
                // Use anywhere from 0 to max possible coins of this denomination
                for (int remainder = amount; remainder > 0; remainder -= coin_value) {
                    ways[amount][d] += ways[remainder][d - 1];
                }
            }
        }
    }
    
    std::cout << ways[TARGET][num_denominations - 1] << std::endl;
}