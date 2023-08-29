<!-- markdown_py README.md > README.html -->

# Prova Final - Sistemas Hardware-Software

Neste prova iremos avaliar os objetivos de aprendizagem trabalhados na segunda metade do curso. Cada pasta contém os arquivos de uma questão da prova, incluindo arquivos `.c` para vocês colocarem suas soluções.

## Regras da prova
1. A prova é individual. São permitidas consultas a todos os materiais de aula, incluindo suas soluções a exercícios de aula e labs. 
1. Não é permitido consultar outras pessoas, sejam do Insper ou não, durante a prova.
1. Esta prova também avalia fluência nos conceitos estudados.
1. A prova terá duração de `três horas`, com início às **16:00** e término às **19:00**. Desconsidere o tempo do proctorio.
1. A entrega da sua prova deverá ser feita via Blackboard. **Não serão aceitas entregas por outros meios**.
1. O item de entrega permite múltiplas tentativas. Sempre que terminar uma questão faça uma entrega completa. Isto visa minimizar problemas com entregas atrasadas.
1. Sua entrega consiste na pasta da prova inteira. Rezipe e entregue via Blackboard.
1. A chamada na prova será pela inicialização do proctorio e assinatura. Não saia sem assinar a lista.
1. Cada questão possui um arquivo específico para resposta. Não altere o nome destes arquivos.
1. Não serão tiradas dúvidas do conteúdo durante a prova.



## Questão 1 (2,5)

A figura *q1/sincronizacao.png* ilustra as relações de dependência entre as partes das funções `thread1`, `thread2`, `thread3` e `thread4`, mostrando que algumas delas poderiam ser feitas de maneira concorrente.

![width:450px](q1/sincronizacao.png)

Seu trabalho nesta questão será:

**1.** criar threads para execução concorrente das funções (**40% da nota**)

**2.** usar semáforos para que a ordem dos prints das partes das tarefas respeitem o diagrama da figura (**60% da nota**)

**OBS**:

- Você não deve introduzir novas dependências. Ou seja, se seu programa criar relações de dependência além das da figura sua questão poderá não receber nota.

- Não altere os `printf` existentes, nem adicione novos.



## Questão 2 (2,5)

Neste exercício, o programa `q2` recebe como argumento da linha de comando **uma palavra** e sua tarefa é fazer uma verificação da mesma.

Exemplo de como seu programa `q2` será chamado:

```
./q2 abc123
```

Uma tarefa comum em programação de sistemas é **integrar com outros programas** instalados. Assim sendo, a palavra (no exemplo é **abc123**) deverá ser examinada pelo programa `verify`, disponível de forma compilada para x86 na pasta da questão.

O programa `verify` retorna valores de `0` a `4` inclusive. Você não precisa se preocupar com o significado de cada código retornado, apenas considere que a validação deve ocorrer.

Entretanto, um problema é que as vezes as chamadas ao programa `verify` demoram muito tempo para retornar devido a erros na sua programação. Assim, você deve trabalhar no arquivo `q2.c` para:

- Criar um processo filho e nele, executar o `verify`, passando o primeiro argumento recebido por `q2` (**30% da nota**).
- No proceso pai, espere `2` segundos e então:
    - Caso o processo filho TENHA finalizado, exiba a mensagem `VERIFY RETORNOU %d\n`, substituindo `%d` pelo retorno do `verify`. O processo pai deve sair retornando o mesmo valor devolvido por `verify` (**30% da nota**).
    - Caso o processo filho NÃO TENHA finalizado, exiba a mensagem `PANE NO SISTEMA VERIFY...\n`, envie um `SIG_KILL` para o processo filho, e repita toda a chamada do `verify` (primeiro passo) até que ele retorne dentro do tempo limite (**40% da nota**).

**Atenção**:

- O executável `verify` também tem a chamada no padrão `./verify palavra`

- Imprima EXATAMENTE conforme solicitado, sem deixar espaços antes ou depois das frases. Dê apenas um `\n` ao final.

**OBS**:

- Trabalhe no arquivo `q2.c` e complete as partes faltantes

- Compile com `gcc q2.c -o q2`

- Deixei um arquivo executável `q2_ref` que exemplifica o comportamento desejado do programa final (é um gabarito!). Teste, por exemplo, com `./q2_ref abc1def` e utilize como referência!

- O executável `verify` tem comportamento aleatório, então as vezes irá demorar mais para conseguir validar a palavra

**Nesta questão você deverá usar as funções de gerenciamento de processos e chamada de executáveis vistas em aula. Você não pode, por exemplo, usar `system`.**



## Questão 3 (2,5)

Abra o arquivo `q3.c`!

Este exercício simula um programa que trabalha em forma de serviço, ou seja, está sempre disponível e nunca finaliza.

Uma nova funcionalidade foi requisitada e você é o responsável por implementá-la: gerar log de inicialização e finalização do programa, de modo que quando o usuário desejar fechar a aplicação, isto seja registrado em um arquivo de texto.

Sua tarefa neste exercício é:

- Na `main`, exibir com `printf` o PID do processo (**10% da nota**)

- Ao inicializar a aplicação com `./q3 logfile.log`, adicionar ao arquivo de log `logfile.log` uma nova linha contendo uma mensagem conforme o exemplo `08:15:03 ./q3 started\n`. Perceba que você deve incluir a hora, minutos e segundos do evento! (**30% da nota**)

- Se o arquivo de log não existir, deve ser criado (não ganha nota, mas se não fizer poderá zerar a questão)

- Ao receber um sinal **SIGINT** ou **SIGTERM**, adicionar ao arquivo de log uma nova linha contendo uma mensagem conforme o exemplo `08:15:03 ./q3 finished with signal sigint\n` (se o sinal for **SIGTERM**, a última palavra deve ser `sigterm`, minúsculo  (**50% da nota pelo registro dos handlers e pelas mensagens estarem funcionando**)

- Se o arquivo de log já existir, ele não deve ser sobrescrito. As mensagens de log são concatenadas ao seu final (**10% da nota**)

**OBS**:

- Você deve criar as funções para serem handlers dos sinais

- O Handler deve ser registrado na main

- Para os arquivos, utilize APENAS as chamadas vistas em aula: `open`, `close`, `read`, `write`. Não pode utilizar `fopen` por exemplo

- Para trabalhar com as horas, consulte o manual: `man 3 time` e `man 3 localtime`

- Para testar, envie sinais pelo terminal e confira o arquivo de log gerado!


## Questão 4 (2,5)

Neste exercício seu trabalho será criar uma função

```
int *extrai_primeiro_int(char *msg)
```

que analisa a string `msg` e retorna um ponteiro para `int` contendo:

- O primeiro valor inteiro (sem sinal) extraído do texto.

Exemplos:

- Para a entrada **Quero 25 destes** você deve retornar um `int` **25**

- Para a entrada **Agora tenho -8, já que perdi ontem** você deve retornar um `int` **8**

Abra o arquivo `q2.c`, analise os testes e implemente a função acima. São 09 testes. Sua nota será pela porcentagem de testes aprovados. Um dos testes já está passando automaticamente, entretanto, caso não haja implementação a nota será ignorada por completo.

Para compilar:

```
gcc -Og -g q4.c -o q4
```

Para rodar os testes automáticos:

```
./q4
```