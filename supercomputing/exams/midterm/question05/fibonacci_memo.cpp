#include <iostream>

int fib(int n, int cache[]) {
    if (n <= 1) {
        return n;
    } else {
	if (cache[n] == 0) {
            cache[n] = fib(n-1, cache) + fib(n-2, cache);
        }
        return cache[n];
    }
}

int main() {
    int n = 30; // Valor de n para calcular Fibonacci
    int cache[n + 1] = {0};
    int result = fib(n, cache);
    std::cout << "Fibonacci de " << n << " é " << result << std::endl;
    return 0;
}
