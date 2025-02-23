#include <stdio.h>

void calcula_media(int vetor[], int n) {
    int i = 0;
    int soma = 0;
    while (i < n) {
        soma += vetor[i];
    }
    double media = (double) soma / n;
    printf("Media: %f\n", media);
}

int main() {
    int n;
    int i = 0;

    printf("Digite o tamanho do array: ");
    scanf("%d", &n);
    int vetor[n];
    
    while (i < n) {
        printf("Digite o valor de posicao %d: ", i);
        scanf("%d", &vetor[i]);
        i++;
    }

    calcula_media(vetor, n);
    return 0;
}
