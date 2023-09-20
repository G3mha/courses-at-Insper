# Baixo Nível Cheatsheet

## Bits e bytes

Agrupamos 8 bits em 1 byte. Um byte é a menor unidade de informação que podemos manipular.

## Número

Como converter:

- Decimal para binário: dividir sucessivamente por 2 e anotar o resto (de baixo para cima)
- Binário para decimal: multiplicar cada bit por 2 elevado a sua posição (de baixo para cima)
- Hexadecimal para binário: converter cada caractere para binário e concatenar

## Tipos em C

- `char`: 1 byte -> biggest number: 2^8 - 1
- `short`: 2 bytes -> biggest number: 2^16 - 1
- `int`: 4 bytes -> biggest number: 2^32 - 1
- `long`: 8 bytes -> biggest number: 2^64 - 1

## Complementos de 2

- Se o bit mais significativo for 0, o número é positivo
- Se o bit mais significativo for 1, o número é negativo e para converter para decimal, fazemos o seguinte:
  - Sinal negativo no inteiro que representa o bit mais significativo
  - Somamos ao outros convertidos

## Big and little endian numbers

Big endian numbers are stored in memory with the most significant byte first. Little endian numbers are stored in memory with the least significant byte first.
_example: in the number 0x12345678, the most significant byte is 0x12 and the least significant byte is 0x78_

## Most and least significant bit

The most significant bit is the bit that is furthest to the left. The least significant bit is the bit that is furthest to the right.
_example: in the number 0b1101, the most significant bit is 1 and the least significant bit is 1_

## Tipos na RAM

- Structs:
  - Structs são armazenadas na memória de forma contígua
  - A ordem dos campos é a ordem em que eles são declarados
  - As variáveis de uma struct quando são declaradas são armazenadas em blocos de 8 em 8 bytes
- Ponteiros:
  - Ponteiros representam um endereço de memória
  - O tamanho de um ponteiro é sempre o mesmo, independente do tipo apontado
- Strings:
  - Strings são armazenadas na memória de forma contígua
  - A string termina com o caractere nulo `\0`
  - O tamanho de uma string é sempre o tamanho da string + 1 (para o caractere nulo)

## Comandos para o gdb

- `info`: mostra informações sobre o programa
  - `info registers`: mostra os valores dos registradores
  - `info functions`: mostra as funções do programa
  - `info variables`: mostra as variáveis do programa
- `break`: define um breakpoint
  - `break <function>`: define um breakpoint na função
  - `break <line>`: define um breakpoint na linha
  - `break <file>:<line>`: define um breakpoint no arquivo na linha
  - `break *<address>`: define um breakpoint no endereço
- `run`: executa o programa
- `next`: executa a próxima linha
- `step`: executa a próxima linha e entra na função se houver
- `continue`: continua a execução do programa
- `print <variable>`: imprime o valor da variável
  - `print <variable>[<index>]`: imprime o valor da variável no índice
  - `print <variable>.<field>`: imprime o valor do campo da variável
  - `print <variable>-><field>`: imprime o valor do campo da variável
- `x`: imprime o conteúdo de uma região de memória
  - `x <number><type><format>`: imprime o conteúdo de uma região de memória
    - `<number>`: número de elementos a serem impressos
    - `<type>`: tipo dos elementos a serem impressos
      - `b`: byte
      - `h`: halfword
      - `w`: word
      - `g`: giantword
    - `<format>`: formato de impressão
      - `x`: hexadecimal
      - `d`: decimal
      - `u`: unsigned decimal
      - `o`: octal
      - `t`: binary
      - `f`: float
      - `a`: address
      - `c`: char
      - `s`: string
      - `i`: instruction
      - `z`: zero-terminated string
      - `Z`: zero-terminated wide string
      - `@`: dereference as address
- `disassemble`: desmonta o código
  - `disassemble <function>`: desmonta o código da função
  - `disassemble <line>`: desmonta o código da linha
  - `disassemble <file>:<line>`: desmonta o código do arquivo na linha
- `set`: define uma variável
  - `set $<register>=<value>`: define o valor do registrador
  - `set $<register>[<index>]=<value>`: define o valor do registrador no índice
  - `set $<register>.<field>=<value>`: define o valor do campo do registrador
  - `set $<register>-><field>=<value>`: define o valor do campo do registrador
  - `set $<register>-><field>[<index>]=<value>`: define o valor do campo do registrador no índice
- `help`: mostra a ajuda
  - `help <command>`: mostra a ajuda do comando

## Instruções em assembly x86-64

`lea` x `mov`: `lea` equivale em C a `p = &v[i]` enquanto `mov` equivale em C a `p = v[i]`

- incq D=>D = D + 1 # Incremento.
- decq D=>D = D – 1 # Decremento.
- negq D=>D = -D # Negativo.
- notq D=>D = ~D # Operador “not” bit-a-bit.
- addq S, D=>D = D + S
- subq S, D=>D = D - S
- imulq S, D=>D = D * S
- salq S, D=>D = D << S # Tanto arit. como lógico.
- sarq S, D=>D = D >> S # Aritmético.
- shrq S, D=>D = D >> S # Lógico.
- xorq S, D=>D = D ^ S
- andq S, D=>D = D & S
- orq S, D=>D = D | S
- cmp S, D=> Compara S com D, como sub, mas não armazena o resultado.

- `lea`: apenas calcula o endereço de memória desejado
  - efeito:  calcula o endereço especificado pelo operando Mem, e armazena em Dst
  - `lea <Mem>, <Dst>`: carrega o endereço de `<source>` para `<destination>`
    - `<Mem>`: operando de endereçamento da forma D(Rb, Ri, S)
      - Exemplo: $0x4(%rax, %rbx, 4)
      - Resultado: 0x4 + 4 * R[%rbx] + R[%rax]
    - `<Dst>`: registrador de destino
      - Exemplo: %rsi
- `mov`: move um valor para um registrador
  - `mov <source>, <destination>`: move o valor de `<source>` para `<destination>`
    - `<source>`: valor a ser movido
    - `<destination>`: registrador de destino
- `add`: soma um valor a um registrador
  - `add <source>, <destination>`: soma o valor de `<source>` ao valor de `<destination>` e escreve o resultado em `<destination>`
    - `<source>`: valor a ser somado
    - `<destination>`: registrador de destino
- `push` e `pop`: empilha e desempilha valores
  - `push <source>`: empilha o valor de `<source>`
    - `<source>`: valor a ser empilhado
  - `pop <destination>`: desempilha o valor de `<destination>`
    - `<destination>`: registrador de destino
- `ret`: retorna da função com o valor do registrador `eax`
  - `ret`: retorna da função com o valor do registrador `eax`
  - `ret <value>`: retorna da função com o valor `<value>`
    - `<value>`: valor a ser retornado
- `sub`: subtrai um valor de um registrador
  - `sub <source>, <destination>`: subtrai o valor de `<source>` do valor de `<destination>`
    - `<source>`: valor a ser subtraído
    - `<destination>`: registrador de destino
- `inc`: incrementa um registrador
  - `inc <destination>`: incrementa o valor de `<destination>`
    - `<destination>`: registrador de destino
- `dec`: decrementa um registrador
  - `dec <destination>`: decrementa o valor de `<destination>`
    - `<destination>`: registrador de destino
- `cmp`: compara dois valores
  - `cmp <source>, <destination>`: compara o valor de `<source>` com o valor de `<destination>`
    - `<source>`: valor a ser comparado
    - `<destination>`: registrador de destino
- `jmp`: salta para um endereço
  - `jmp <address>`: salta para o endereço
    - `<address>`: endereço de destino
- `je`: salta para um endereço se o resultado da última comparação for igual
  - `je <address>`: salta para o endereço se o resultado da última comparação for igual
    - `<address>`: endereço de destino
- `jne`: salta para um endereço se o resultado da última comparação for diferente
  - `jne <address>`: salta para o endereço se o resultado da última comparação for diferente
    - `<address>`: endereço de destino
- `jg`: salta para um endereço se o resultado da última comparação for maior
  - `jg <address>`: salta para o endereço se o resultado da última comparação for maior
    - `<address>`: endereço de destino
- `jge`: salta para um endereço se o resultado da última comparação for maior ou igual
  - `jge <address>`: salta para o endereço se o resultado da última comparação for maior ou igual
    - `<address>`: endereço de destino
- `jl`: salta para um endereço se o resultado da última comparação for menor
  - `jl <address>`: salta para o endereço se o resultado da última comparação for menor
    - `<address>`: endereço de destino
- `jle`: salta para um endereço se o resultado da última comparação for menor ou igual
  - `jle <address>`: salta para o endereço se o resultado da última comparação for menor ou igual
    - `<address>`: endereço de destino
- `call`: chama uma função
  - `call <function>`: chama a função
    - `<function>`: função a ser chamada
- (registrador1, registrador2, escala, deslocamento): endereço de memória
  - `<registrador1>`: registrador base
  - `<registrador2>`: registrador de índice
  - `<escala>`: escala do registrador de índice
  - `<deslocamento>`: deslocamento do endereço

## Operandos

- `Mem`: operando de endereçamento da forma D(Rb, Ri, S)
  - Exemplo: $0x4(%rax, %rbx, 4)
  - Resultado: 4 + 4 * R[%rbx] + R[%rax]
- `Imm`: operando imediato
  - Exemplo: $0x4
- `Reg`: registrador
  - Exemplo: %rax
- Não é permitido operações do tipo Mem to Mem

## Registradores

- `rax`: registrador de retorno
- Argumentos inteiros ou ponteiros são passados nos registradores (nesta ordem):
  - `%rdi`
  - `%rsi`
  - `%rdx`
  - `%rcx`
  - `%r8`
  - `%r9`

## Códigos de condição

CF: Carry Flag => Resultado da operação não cabe no registrador UNSIGNED
SF: Sign Flag => Resultado da operação é negativo
OF: Overflow Flag => Resultado da operação não cabe no registrador SIGNED
ZF: Zero Flag => Resultado da operação é zero

## Tamanho e tipo dos registradores

- 64 bits (%rax, %rdi e outros que começam com r): long, unsigned long ou ponteiro;
- 32 bits (%eax, %edi e outros que começa com e e os que terminam em d como r10d): int ou unsigned int;
- 16 bits (%ax, %di e outros com duas letras somente terminando em x): short ou unsigned short
- 8 bits (%al, %ah e outros com duas letras terminando em h ou l): char ou unsigned char.
- **endereços de memória: 32 bits**
