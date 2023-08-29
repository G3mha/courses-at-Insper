# 10-Processos

Exercício para entrega.

Desenvolva um programa em `finder.c` que encontre índice da primeira ocorrência de um determinado número `x` em um vetor `A` de inteiros com `n` posições.

Para isso, deverão ser criados `k` processos filhos sendo, cada um deles, responsável por procurar em uma região `r` do vetor.

Quando o número for encontrado, o processo filho deve devolver ao processo pai o índice onde foi encontrado o número. Caso ele não tenha encontrado o número, deve devolver `-1`. Caso o número ocorra em mais de uma posição no filho, é retornado sempre o primeiro índice onde foi encontrado o número.

Sua tarefa é criar um programa que realize a busca por um elemento `x` em um array. O array `A` terá `n` elementos do tipo `int`. Seu programa deve:
- Ler o elemento que deve ser buscado
- Ler o tamanho do array
- Ler os elementos do array

Então, seu programa deve criar `k` processos, sendo que cada processo deve buscar pelo elemento `x` em parte do array, ou seja, iremos dividir o array em `k` pedaços iguais, sendo que cada processo deve buscar o elemento apenas na parte que o foi atribuido.

Então você deve:
- Ler a quantidade de processos
- Criar os processos filhos

Cada processo filho deve:
- Esperar `5` segundos antes de iniciar a busca (apenas os filhos esperam, o pai não!)
- Iniciar a busca na parte do array atribuida a ele
- Retorne adequadamente `-1` ou o índice onde foi encontrado o número

Restrições:
- Considere que o tamanho da região `r` será de no mínimo 1 e no máximo 200
- Considere que $n\%k=0$

O processo pai deve exibir uma mensagem `Elemento não encontrado!` o então uma mensagem no padrão `Elemento 778 encontrado pelo processo 1 no indice 7!`.

Compile o programa com
```
make
```

E verifique o funcionamento com
```
./finder
```

Aqui, será útil criar alguns arquivos para testes, utilizando redirecionamento da entrada padrão:
```
./finder < in1.txt
```

Na pasta `in` deixamos 50 arquivos de testes. Você também pode criar os seus!

## Entendendo melhor!

Considere um array `A` de tamanho 16 (`n = 16`). Imagine que foi definido uma busca pelo valor `778` em `4` processos (`x = 778`,`k = 4`).

Cada processo deveria trabalhar em uma região `r` de tamanho `4` (porque `16 // 4 = 4`).

![](img/ex.png)

Como resultado, gostaríamos de obter:
```
Elemento 778 encontrado pelo processo 1 no indice 7!
```

## Exemplo

Considere as entradas (poderiam estar no arquivo `in1.txt`):
```console
200
4
100
200
300
400
2
```

Então, queremos buscar pelo valor `200` em um array de tamanho `4`, sendo `[100, 200, 300, 400]` utilizando `2` processos.

Como resultado da execução de `./finder`, este seria o terminal:
```console
Qual o elemento a ser buscado? 200
Qual o tamanho do array? 4
Digite os 4 elementos do array:
100 200 300 200
Qual a quantidade de processos? 2
Criou filho 0 com PID=137563, r=[0,2)
Criou filho 1 com PID=137564, r=[2,4)
Processo pai esperando os filhos finalizarem...
Processo 1 com PID=137564 finalizou retornando -1
Processo 0 com PID=137563 finalizou retornando 1
Elemento 200 encontrado pelo processo 0 no indice 1!
```

Então você pode rodar com:
```console
./finder < in1.txt
```
Perceba que a mensagem `"Elemento 200 encontrado pelo processo 0 no indice 1!"` sempre será a última coisa exibida no terminal!

## Bases de testes e Comparação

Deixamos vários arquivos `in*.txt` que poderão ser utilizados para testar o seu `finder`!

Ainda, há um executável `finder-gabarito` para que comparem os resultados esperados. Então você pode rodar `./finder < in2.txt` e conferir se a última linha na saída confere com `./finder-gabarito < in2.txt`.

## Como começar?

Utilize os exercícios da aula 14 como referência, especialmente os da **Lista Extra**.

## Prazo
- Atividade do final da aula 14 https://insper.github.io/SistemasHardwareSoftware/aulas/14-processos/
- Prazo: https://insper.github.io/SistemasHardwareSoftware/sobre/

## Como entregar?
Para entregar a atividade, envie para o github suas alterações e suba uma tag com o padrão de nomenclatura `atv10.x.y`, substituindo `x` e `y` por qualquer número inteiro! Ex:

```
git tag -a atv10.0.0 -m "enviando a atv10.0.0"
git push origin atv10.0.0
```
