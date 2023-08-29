<!-- markdown_py README.md > README.html -->
<!-- pandoc README.md -f markdown -t html -s -o README.html --metadata title="AF SisHard 23-1" -->

# Prova Final - Sistemas Hardware-Software

Neste prova iremos avaliar os objetivos de aprendizagem trabalhados na segunda metade do curso. Cada pasta contém os arquivos de uma questão da prova, incluindo arquivos `.c` para vocês colocarem suas soluções.

## Regras da prova
1. A prova é individual. São permitidas consultas a todos os materiais de aula, incluindo suas soluções a exercícios de aula e labs. 
1. Não é permitido consultar outras pessoas, sejam do Insper ou não, durante a prova.
1. Esta prova também avalia fluência nos conceitos estudados.
1. A prova terá duração de `três horas`, com início às **13:30** e término às **16:30**. Desconsidere o tempo do proctorio.
1. A avaliação da sua prova deverá ser feita pelos testes no github. Além disso, é obrigatório enviar o zip da prova no Blackboard.
1. O item de entrega permite múltiplas tentativas. Sempre que terminar uma questão faça uma entrega completa. Isto visa minimizar problemas com entregas atrasadas.
1. Sua entrega consiste na pasta da prova inteira. Rezipe e entregue via Blackboard.
1. A chamada na prova será pela inicialização do proctorio e assinatura. Não saia sem assinar a lista.
1. Cada questão possui um arquivo específico para resposta. Não altere o nome destes arquivos.
1. Não serão tiradas dúvidas do conteúdo durante a prova.
1. Fica proibido o uso de ferramentas de geração de código como o copilot. Sujeito a código de ética.

## Antes de começar a resolver

Cole os arquivos desta prova em seu repositório de entregas da disciplina, tendo estes caminhos a partir da raiz:

- `provas/af/q1`
- `provas/af/q2`
- `provas/af/q3`
- `provas/af/q4`

Vamos utilizar o servidor para receber a nota em cada questão. Será necessário soltar releases! A correção será sequencial, ao primeiro problema, irá parar (ou seja, precisa resolver os problemas anteriores para que os próximos critérios sejam considerados).

As issues já terão a sua nota no exercício. Como de costume, um **pass** significa que o servidor não encontrou problemas em sua solução (não que ela esteja correta!). Teremos uma fase de validação extra pelos professores, envolvendo, por exemplo:

- O uso de funções não permitidas poderá resultar na anulação da nota no exercício.
- Os testes pegam apenas alguns casos, garanta que sua solução funciona conforme o requisitado no enunciado.
- Tentativas de burlar os testes resultarão em zero na prova.
- Se passou mas está errado, a nota será desconsiderada.

---

## Questão 1 (2,5)
<style scoped>section { font-size: 20px; }</style>

A figura *q1/sincronizacao.png* ilustra as relações de dependência entre as partes das funções `thread1, thread2, thread3` e `thread4`, mostrando que algumas delas poderiam ser feitas de maneira concorrente.

![](q1/sincronizacao.png)


Seu trabalho nesta questão será:

1. criar threads para execução concorrente das funções. (**40% da nota**).
2. usar semáforos para que a ordem dos prints das partes das tarefas respeitem o diagrama da figura. (**60% da nota**).

**OBS**:

- Você não deve introduzir novas dependências. Ou seja, se seu programa criar relações de dependência além das da figura seu trabalho valerá no máximo 50%.

- Não altere os `printf` existentes, nem adicione novos.

**Como descrubro minha nota?**:

Será pelo corretor automático. Suba as alterações para o git e solte uma release:

```
git tag -a afq1.x.y -m "enviando a afq1.x.y"
git push origin afq1.x.y
```

---

## Questão 2 (2,5)

Neste exercício, o programa `q2` recebe como argumento da linha de comando **o nome de um arquivo de imagem** e um **preço** por chamada de API. Sua tarefa é chamar outro programa, que simula um reconhecimento de textos contidos na imagem, e calcular o gasto total com as chamadas da API.

Exemplo de como seu programa `q2` será chamado:

```
./q2 cnh_do_joao.png 0.1
```

Uma tarefa comum em programação de sistemas é **integrar com outros programas** instalados. Assim sendo, a **imagem** (no exemplo é `cnh_do_joao.png`) deverá ser examinada pelo programa `ocr`, disponível de forma compilada para x86 na pasta da questão.

O executável `ocr` tem a chamada no padrão `./ocr arquivo 0` onde `arquivo` representa um arquivo de imagem e `0` representa quantas vezes você já tentou processar este arquivo. Assim sendo, na primeira vez que o `ocr` é chamado para processar o arquivo `jose.jpg` devemos utilizar `./ocr jose.jpg 0`. Caso o processo falhe, então tentamos novamente usando `./ocr jose.jpg 1`. Se falhar mais uma vez, o uso deve ser `./ocr jose.jpg 2` e assim sucessivamente até que ele saia com sucesso.

O programa `ocr` retorna `0` quando a chamada é feita com sucesso, ou `-1` quando recebe uma chamada errada (quantidade incorreta de argumentos). Você não precisa se preocupar com o que de fato o programa `ocr` faz, apenas considere que a ele deve processar a imagem e retornar um resultado (a imagem sequer deve existir, é tudo simulado).

Entretanto, um problema é que as vezes as chamadas ao programa `ocr` são interrompidas devido a sinais recebidos (ele foi programado por um péssimo programador). Assim, você deve trabalhar no arquivo `q2.c` para:

- Criar um processo filho e nele, executar o `ocr`, passando para o `ocr` o primeiro argumento recebido pelo executável `q2` (que é a imagem) e um inteiro com a quantidade de vezes que você já tentou processar esta imagem (na primeira vez, passe `0`, se tiver sinal, passe `1`).
- No proceso pai:
    - Caso o processo filho TENHA finalizado normalmente, exiba a mensagem `OCR TERMINOU NORMALMENTE!\n` (**10% da nota**).
    - Caso o processo filho TENHA SIDO sinalizado, exiba a mensagem `OCR TERMINOU COM SINAL %s\n`, substituindo `%s` pelo texto que descreve o sinal. (**40% da nota**)
    - Repita a chamada do `ocr` (primeiro passo) até que ele finalize normalmente. No final, imprima o gasto total (double) no padrão `TIVEMOS UM GASTO TOTAL DE %.2f\n`. Aqui, lembre de atualizar em mais um a quantidade de vezes que você já tentou processar esta imagem (**50% da nota**)

**Atenção**:

- Imprima EXATAMENTE conforme solicitado, sem deixar espaços antes ou depois das frases. Dê apenas um `\n` ao final. Por via das dúvidas, utilize `fflush(stdout)`.

- O gasto total é calculado pela **quantidade de vezes que é preciso chamar** o `ocr` multiplicada pelo **preço** por chamada de API.

- Trabalhe no arquivo `q2.c` e complete as partes faltantes

- Compile com `gcc -g q2.c -o q2`

- Deixei um arquivo executável `q2_ref` que exemplifica o comportamento desejado do programa final (é um gabarito!). Teste, por exemplo, com `./q2_ref escrita.png 2.5` e utilize como referência!

- O executável `ocr` tem comportamento determinístico. Se você programar corretamente e passar os argumentos corretamente para o `ocr`, deve obter as mesmas saídas que o `q2_ref` para as mesmas entradas.

**Nesta questão você deverá usar as funções de gerenciamento de processos e chamada de executáveis vistas em aula. Você não pode, por exemplo, usar `system`.**

**Como descrubro minha nota?**:

Será pelo corretor automático. Suba as alterações para o git e solte uma release:

```
git tag -a afq2.x.y -m "enviando a afq2.x.y"
git push origin afq2.x.y
```

---

## Questão 3 (2,5)

Abra o arquivo `q3.c`!

Esta aplicação simula o processamento sequencial de diversas linhas, onde cada linha representa uma tarefa.

Uma nova funcionalidade foi requisitada nesta aplicação e você é o responsável por implementá-la: queremos poder guardar o status atual do processamento em algum arquivo para poder continuar o processamento uma outra hora.

Seu objetivo neste exercício:

- Ao receber um sinal **SIGTERM** ou **SIGINT**, antes de finalizar, criar um arquivo `q3_status.txt` contendo em seu conteúdo informações sobre a última linha processada seguida de um `'\n'`. Ex de conteúdo do arquivo a ser gerado: `LINHA_PROC=15`. (**60% da nota pelo registro do handler e pela mensagem no arquivo**)

- O programa sai com o mesmo sinal que recebeu. (**20% da nota**)

- Se o arquivo já existir, ele deve ser sobrescrito. (**20% da nota**)

**OBS**:

- Você deve criar as funções para serem handlers dos sinais

- Os Handlers devem ser registrados na `main` e serem auto-contidos.

- Para os arquivos, utilize APENAS as chamadas vistas em aula: `open`, `close`, `read`, `write`. Não pode utilizar `fopen`, `fgets`, `fscanf` por exemplo. Se utilizar, a nota do ex será zero (mesmo que passe nos testes).

- Para testar, envie sinais pelo terminal e confira o arquivo de log gerado!

- O handler deve utilizar a variável global `linha_proc` para saber a última linha processada.

- Não iremos continuar a tarefa a próxima vez que rodarmos o executável, estamos apenas simulando! Queremos salvar onde paramos para poder continuar, mas na verdade não iremos continuar (uma coisa de cada vez!)


**Como descrubro minha nota?**:

Será pelo corretor automático. Suba as alterações para o git e solte uma release:

```
git tag -a afq3.x.y -m "enviando a afq3.x.y"
git push origin afq3.x.y
```


---

## Questão 4 (2,5)

Neste exercício, vamos fazer o reconhecimento de CEPs em um arquivo de textos, dividindo a carga de trabalho entre threads!

O programa `q4` recebe como argumento da linha de comando **uma quantidade total de threads a serem criadas** e o **nome de um arquivo**.

Exemplo de como seu programa `q4` será chamado:

```
./q4 2 arquivo.txt
```

onde `2` é a quantidade de threads a serem criadas e `arquivo.txt` é o arquivo que contem em uma única linha palavras a serem processadas pelas threads.

Exemplo de conteúdo do `arquivo.txt`:
```
eu moro no cep numero 70901-001 mas trabalho no 18900-199 longe demais
```

Perceba que na `main` já são criadas as `threads` da função `cep_validation_thread`. A thread recebe como argumento uma estrutura que contém o descritor de um arquivo (que é compartilhado entre todas as threads existentes). Cada thread executa o seguinte algoritmo em alto nível:

1. REPITA:
    1. Tenta ler uma palavra do arquivo compartilhado:
        1. SE não conseguiu ler:
            1. PARE
    1. SE a palavra lida for um CEP, ENTÃO:
        1. SOMA 1 na variável `count_ceps`

Boa parte do código já está desenvolvido. Sua primeira tarefa será programar a função `char *read_word(int fd)`, que tem por objetivo ler uma palavra de um arquivo.

Assim que tiver feito esta etapa, você irá perceber que boa parte do código já irá funcionar.

Tente compilar com:

```
gcc -g q4.c -o q4 -pthread
```

E executar com apenas uma thread:

```
./q4 1 in01.txt
```

Você verá que a resposta gerada estará correta. Entretanto, ao executar com arquivos maiores e mais threads, perceba que o resultado deixará de ser consistente. Tente rodar várias vezes o código:

```
./q4 8 in03.txt
```

Então, sua tarefa envolverá tratar corretamente as regiões críticas.

Perceba que, diferente do lab de threads, aqui não existe uma pré-definição de quais palavras devem ser tratadas por quais threads!

Suas tarefas:

- Programar a função `char *read_word(int fd)`. Considere que o arquivo já está aberto e deve ser fechado apenas na `main`. Para ler, é obrigatório utilizar apenas a chamada `read`. (**40% da nota**)

- Fazer alterações na main e na função `cep_validation_thread` para que as regiões críticas sejam tratadas adequadamente. O código deve ter sua funcionalidade geral mantida (continuar o mesmo número de threads, continuar a cada thread poder ler uma palavra indefinida do arquivo) e apenas estruturas de sincronização devem ser adicionadas para tratar as regiões críticas. Se usar variável global, haverá desconto. (**40% da nota**).

- Programa passa no valgrind sem erros. Aqui, também será necessário liberar memórias alocadas na main no código que receberam pronto! (**20% da nota**, apenas se resolveu corretamente os anteriores)

**OBS**:

- Trabalhe no arquivo `q4.c` e complete as partes faltantes

- Compile com `gcc -g q4.c -o q4 -pthread`

- Faça seus próprios arquivos de teste personalizados!

- Se utilizar variáveis globais, haverá desconto.


**Como descrubro minha nota?**:

Será pelo corretor automático. Suba as alterações para o git e solte uma release:

```
git tag -a afq4.x.y -m "enviando a afq4.x.y"
git push origin afq4.x.y
```
