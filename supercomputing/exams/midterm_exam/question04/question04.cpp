#include <iostream>
#include <vector>

// Função para multiplicar duas matrizes
std::vector<std::vector<int> > multiplicarMatrizes(const std::vector<std::vector<int> >& a,
                                                 const std::vector<std::vector<int> >& b) {
    int n = a.size();
    int m = a[0].size();
    int p = b[0].size();
    
    std::vector<std::vector<int> > c(n, std::vector<int>(p, 0));

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < p; ++j) {
            for (int k = 0; k < m; ++k) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }

    return c;
}

int main() {
    int tamanho = 300; // Tamanho da matriz
    std::vector<std::vector<int> > a(tamanho, std::vector<int>(tamanho, 1));
    std::vector<std::vector<int> > b(tamanho, std::vector<int>(tamanho, 2));

    // Multiplicação das matrizes
    auto resultado = multiplicarMatrizes(a, b);

    std::cout << "Multiplicação de matrizes concluída." << std::endl;

    return 0;
}
