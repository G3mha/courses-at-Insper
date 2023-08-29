# 13-Threads

Exercício para entrega.

Desenvolva um programa em `finderThread.c` que encontre índice da primeira ocorrência de um determinado número `x` em um vetor `A` de inteiros com `n` posições.

Para isso, deverão ser criados `k` threads sendo, cada uma delas, responsável por procurar em uma região `r` do vetor.

Quando o número for encontrado, a thread deve devolver à função principal ($main()$) o índice onde foi encontrado o número. Caso ela não tenha encontrado o número, deve devolver `-1`. Caso o número ocorra em mais de uma posição na thread, é retornado sempre o primeiro índice onde foi encontrado o número.

Sua tarefa é criar um programa que realize a busca por um elemento `x` em um array. O array `A` terá `n` elementos do tipo `int`. Seu programa deve:

- Ler o elemento que deve ser buscado
- Ler o tamanho do array
- Ler os elementos do array

Então, seu programa deve criar `k` threads, sendo que cada thread deve buscar pelo elemento `x` em parte do array, ou seja, iremos dividir o array em `k` pedaços iguais, sendo que cada thread deve buscar o elemento apenas na parte que a foi atribuida.

Então você deve:

- Ler a quantidade de threads
- Criar as threads

Cada thread deve:

- Esperar `5` segundos antes de iniciar a busca (apenas os filhos esperam, o $main()$ não!)
- Iniciar a busca na parte do array atribuida a ele
- Retorne adequadamente `-1` ou o índice onde foi encontrado o número

Restrições:

- Considere que o tamanho da região `r` será de no mínimo 1 e no máximo 200
- Considere que $n\%k=0$

A função $main()$ deve exibir uma mensagem `Elemento não encontrado!` o então uma mensagem no padrão `Elemento 778 encontrado pela thread 1 no indice 7!`.

Compile o programa com

```bash
gcc finderThread.c -o finderThread -pthread
```

E verifique o funcionamento com

```bash
./finderThread
```

Aqui, será útil criar alguns arquivos para testes, utilizando redirecionamento da entrada padrão:

```bash
./finderThread <./in/in01.txt
```

Na pasta `in` deixamos 50 arquivos de testes. Você também pode criar os seus!

## Entendendo melhor!

Considere um array `A` de tamanho 16 (`n = 16`). Imagine que foi definido uma busca pelo valor `778` em `4` threads (`x = 778`,`k = 4`).

Cada thread deveria trabalhar em uma região `r` de tamanho `4` (porque `16 // 4 = 4`).

![ex](img/ex.png)

Como resultado, gostaríamos de obter:

```bash
Elemento 778 encontrado pela thread 1 no indice 7!
```

## Exemplo

Considere as entradas (poderiam estar no arquivo `./in/in01.txt`):

```console
200
4
100
200
300
400
2
```

Então, queremos buscar pelo valor `200` em um array de tamanho `4`, sendo `[100, 200, 300, 400]` utilizando `2` threads.

Como resultado da execução de `./finderThread`, este seria o terminal:

```console
Qual o elemento a ser buscado? 200
Qual o tamanho do array? 4
Digite os 4 elementos do array:
100 200 300 200
Qual a quantidade de threads? 2
Criou thread 0, r=[0,2]
Criou thread 1, r=[2,4]
Funcao main() espera as threads finalizarem...
Thread 0 finalizou retornando 1
Thread 1 finalizou retornando -1
Elemento 200 encontrado pela thread 0 no indice 1!
```

Então você pode rodar com:

```console
./finderThread < ./in/in01.txt
```

Perceba que a mensagem `"Elemento 200 encontrado pela thread 0 no indice 1!"` sempre será a última coisa exibida no terminal!

## Bases de testes e Comparação

Deixamos vários arquivos `./in/in*.txt` que poderão ser utilizados para testar o seu `finderThread`!

Ainda, há um executável `finderThread-gabarito` para que comparem os resultados esperados. Então você pode rodar `./finderThread < ./in/in02.txt` e conferir se a última linha na saída confere com `./finderThread-gabarito <./in/in02.txt`.

## Como começar?

Utilize os exercícios da aula 19 como referência, especialmente os da **Lista Extra**.

## Prazo

- Atividade do final da aula 19 https://insper.github.io/SistemasHardwareSoftware/aulas/19-threads/
- Prazo: https://insper.github.io/SistemasHardwareSoftware/sobre/

## Como entregar?

Para entregar a atividade, envie para o github suas alterações e suba uma tag com o padrão de nomenclatura `atv13.x.y`, substituindo `x` e `y` por qualquer número inteiro! Ex:

```bash
git tag -a atv13.0.0 -m "enviando a atv13.0.0"
git push origin atv13.0.0
```
