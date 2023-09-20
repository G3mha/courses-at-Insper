# 08-malloc

Exercícios para entrega. Faça nesta ordem:
- Abra o arquivo *copia_string.c* e implemente a função *mystrcpy*. Esta função recebe uma string, e devolve uma cópia da string original, alocando apenas o espaço realmente necessário.
- Abra o arquivo *concatena_string.c* e implemente a função *mystrcat*. Esta função recebe duas string, e devolve uma terceira que é a concatenação das duas primeiras, alocando apenas o espaço realmente necessário.
- Regras:
    - Proibido importar `string.h`, você deve fazer suas próprias funções auxiliares para calcular o tamanho de uma string por exemplo.
- Atividade do final da aula 10 https://insper.github.io/SistemasHardwareSoftware/aulas/10-malloc/
- Prazo: https://insper.github.io/SistemasHardwareSoftware/sobre/
- Teste executando:
```
make copia_string
make concatena_string
```
- Confira erros de memória com `valgrind --leak-check=yes ./executavel` substituindo executável por cada uma das suas soluções compiladas!
- Para entregar a atividade, envie para o github suas alterações e suba uma tag com o padrão de nomenclatura `atv8.x.y`, substituindo `x` e `y` por qualquer número inteiro! Ex:

```
git tag -a atv8.0.0 -m "enviando a atv8.0.0"
git push origin atv8.0.0
```


