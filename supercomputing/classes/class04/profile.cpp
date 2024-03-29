#include <iostream>
#include <cmath>
#include <chrono>

void heavyCalculation() {
    for (int i = 0; i < 100000; ++i) {
        double result = std::sqrt(static_cast<double>(i));
    }
}

void intermediateFunction() {
    for (int i = 0; i < 1000; ++i) {
        heavyCalculation();
    }
}

void mainFunction() {
    for (int i = 0; i < 5; ++i) {
        intermediateFunction();
    }
}

int main() {
    auto start = std::chrono::high_resolution_clock::now();

    mainFunction();

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    std::cout << "Time taken: " << duration.count() << " milliseconds" << std::endl;

    return 0;
}

