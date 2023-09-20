# Prova Sistemas Hardware Software

<!-- markdown_py README.md > README.html -->
<!-- pandoc README.md -f markdown -t html -s -o README.html --metadata title="AI SisHard 23-1" -->

### Duração: 180 minutos
### 5 Questões

**ATENÇÃO:** O proctorio estará com tempo superior a 180 minutos, desconsidere.

* Em cada questão é indicado um arquivo para colocar sua resposta.
* É permitido consultar o material da disciplina durante a prova (repositório da disciplina e seu repositório de atividades), além de seus materiais físicos. **Ficam proibidas consultas a materiais de outros alunos ou pesquisas na Internet.**
* Fica proibido o uso de ferramentas de IA ou auto-complete
* A prova é individual. Qualquer consulta a outras pessoas durante a prova constitui violação ao Código de Ética do Insper. Não abra E-mail, Whatsapp, Discord, etc.
* A prova deve ser um exercício intelectual seu. Fica proibido utilizar programas ou qualquer outra ferramenta que resolva para você os exercícios (engenharia reversa).
* Fica proibido o uso de ferramentas de geração de código como o copilot. Sujeito a código de ética.
* Para conversões de base, pode utilizar a calculadora do Ubuntu.

## Instalação

Se receber reclamações como `cannot find -lsystemd`, instale com:

`sudo apt update`

`sudo apt install build-essential libsystemd-dev`

## Questão 01

Se não conseguir rodar o executável `./q1`, execute o comando:

`chmod +x q1`

Neste exercício, você deve responder `V` ou `F` para as afirmações retornadas.

Passe suas respostas para o arquivo `solucao.txt`, uma resposta em cada linha (deixe uma linha em branco no final) e execute com

./q1 < solucao.txt

**Onde deixo minhas respostas?**: no arquivo `solucao.txt`. Uma resposta em cada linha, com uma linha em branco no final!

**Critérios de avaliação**: sua nota será a proporção de respostas **corretas** (por motivos óbvios, correção posterior a prova)

**Pontos possíveis**: 1,0


## Questão 02

Se não conseguir rodar o executável `./q2`, execute o comando:

`chmod +x q2`

Este exercício é um mini **HackerLab**. Utilize seus conhecimentos adquiridos para descobrir a senha de cada nível!

Coloque as respostas no arquivo `solucao.txt` e rode

> `./q2 < solucao.txt`

**Preciso fazer engenharia reversa?** Você vai precisar analisar o assembly para entender as operações envolvidas, mas não precisa entregar esta tradução. Sua entrega deve ser apenas as entradas no arquivo `solucao.txt`.

**Onde deixo minhas respostas?**: no arquivo `solucao.txt`

**Critérios de avaliação**: A nota será disponibilizada na saída padrão!

**Pontos possíveis**: 2,0


## Questão 3

Faça engenharia reversa das funções `ex3` continda em `q3.o`.

Coloque sua solução no arquivo `solucao.c`, chamando sua função de `ex3_solucao`.

Para compilar os testes e sua solução use

> `gcc -Og -g -fno-stack-protector solucao.c q3.o -lsystemd -lm -o q3`

Este exercício possui testes automáticos para servir como auxílio.

Execute os testes automáticos com:
> `./q3`

Observe, nos critérios de avaliação, que acertar o cabeçalho da função e fazer uma versão legível do código também fazem parte da nota.

**Critérios de avaliação**:
* 50% - pela proporção de testes com PASS (sem truques para burlá-los)
* 20% - acertar os tipos das chamadas de função
* 30% - código legível (e correto), sem construções estranhas (entregue a melhor versão do seu exercício, se fez if-goto e depois C legível, entregue apenas C legível!)

**OBS**:
* Os testes não são exaustivos. Você pode passar em todos e sua função ainda não estar completamente correta. Neste caso, a nota com "proporção de testes com PASS" ficará completa, mas as demais poderão sofrer desconto.

**Pontos possíveis**: 2,0

## Questão 4

Faça engenharia reversa da função `ex4` contida em `q4.o`.

Coloque sua solução no arquivo `solucao.c`, chamando sua função de `ex4_solucao`.

Para compilar os testes e sua solução use

> `gcc -Og -g -fno-stack-protector solucao.c q4.o -lsystemd -lm -o q4`

Este exercício possui testes automáticos para servir como auxílio.

Observe, nos critérios de avaliação, que acertar o cabeçalho da função e fazer uma versão legível do código também fazem parte da nota. Ainda, neste exercício você precisará tentar entender o que o programa faz. Deixe a sua explicação no arquivo `explicacao.md` dentro da pasta `q4.

Execute os testes automáticos com:
> `./q4`

**Critérios de avaliação**:
* 40% - pela proporção de testes com PASS (sem truques para burlá-los)
* 20% - acertar os tipos das chamadas de função
* 30% - código legível e sem construções estranhas (entregue a melhor versão do seu exercício, se fez if-goto e depois C legível, entregue apenas C legível!)
* 10% - explicou corretamente o que o programa faz (preencher arquivo `explicacao.md`).

**OBS**:
* Os testes não são exaustivos. Você pode passar em todos e sua função ainda não estar completamente correta. Neste caso, a nota com "proporção de testes com PASS" ficará completa, mas as demais poderão sofrer desconto.

**Pontos possíveis**: 3,0


## Questão 5

Neste exercício seu trabalho será criar uma função

```
char *remove_comentarios(char *funcao)
```

que recebe por parâmetro a string `funcao` com o código fonte de uma função na linguagem C, sua função analisa e retorna um ponteiro para **UMA NOVA string**, alocada dinamicamente com todos os comentários de uma linha removido do código fonte da função.

Exemplos:

- Para a entrada:
```c
void f1(int x, int y){
 int z;
 // soma dois numeros
 z = x + y;
 // retorna valor calculado
 return z;
}
```



- Para a entrada acima, sua função deve retornar:

```c
void f1(int x, int y){
 int z;
 
 z = x + y;
 
 return z;
}
```

- Para entender melhor, perceba o conteúdo linha a linha (observe bem o padrão de espaços):
    - Entrada:
```c
"void f1(int x, int y){\n"
" int z;\n"
" // soma dois numeros\n"
" z = x + y;\n"
" // retorna valor calculado\n"
" return z;\n"
"}"
```
    - Saída:
```c
"void f1(int x, int y){\n"
" int z;\n"
" \n"
" z = x + y;\n"
" \n"
" return z;\n"
"}"
```

A representação linha a linha foi utilizada apenas para seu melhor entendimento. Ela representa a concatenação de strings, ou seja, na função você receberá todo o código em uma variável `char *funcao`. Utilize seus conhecimentos de debug de código e de programação em C para sanar suas dúvidas restantes sobre as strings recebidas!

Abra o arquivo `remove.c`, e implemente a função. Sua nota será calculada pela porcentagem de testes aprovados, considerando um total de **cinco testes**.

Para compilar:

```
gcc -Og -g q5.o remove.c -o q5
```

Para rodar os testes automáticos:

```
./q5
```

**OBS**:

- É proibido utilizar funções da `string.h`. Ex: strlen, strcpy, strrchr, etc. Se utilizar, a questão será zerada.

- Precisa funcionar para qualquer código fonte, se tiver testes fixos apenas para burlar os testes, irá zerar!

- Nota conforme proporção dos testes aprovados. Se tiver algum erro no valgrind, a questão terá um desconto de 50%.

- A nota da questão virá pelos testes automáticos e valgrind. A análise visual pelo professor será apenas para confirmar que nenhuma regra foi quebrada!


**Pontos possíveis**: 2,0