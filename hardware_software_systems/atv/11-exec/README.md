# 11-Mini-immortal

Nesta atividade para entrega, iremos trabalhar com ferramentas e bibliotecas para criação de um **Monitor de Processos**. Nosso programa, chamado de  `immortal`, será responsável por executar **outro programa** e **monitorar seu processo**, garantindo que seja **reiniciado** sempre que finalizado (por qualquer motivo).

## Como compilar?

Para compilar, utilize obrigatoriamente:

```console
$ gcc -Wall -Wno-unused-result -Og -g immortal.c -o immortal
```

## Como meu programa será executado?!

O `immortal` será utilizado pelo usuário como na linha de comando:


```console
$ ./immortal ./path/para/algum/programa
```

Você deverá executar o `programa` em um processo filho e monitorá-lo, subindo novamente a cada vez que for finalizado.

Supondo que o usuário chamou:

```console
$ ./immortal /usr/bin/gnome-calculator
```

A cada execução (cada nova vez que o usuário clica no **X** para fechar a janela), exiba na saída padrão:

```console
starting /usr/bin/gnome-calculator with pid=125471
```

## Descobrir path de programas

Para descobrir o path dos programas do terminal, você pode utilizar o `which`:
```console
which gnome-calculator
```

## Gabarito

Para terem uma referência de implementação, deixamos um gabarito compilado no arquivo `immortal-gabarito`. Teste e veja o comportamento esperado!

```console
./immortal-gabarito /usr/bin/gnome-calculator
```

Além disso, deixamos algumas aplicações genéricas na pasta. Elas podem ser utilizadas para teste:
- `infinito`: é um executável que nunca finaliza. Se você chamar `./immortal ./infinito` é esperado que apenas um processo filho seja criado e apenas uma vez (já que o `infinito` nunca retorna!)
- `timecrash`: finaliza com erro depois de algum tempo.  Se você chamar `./immortal ./timecrash` é esperado que primeiramente apenas um processo filho seja criado. Depois de alguns segundos, o filho irá finalizar, então você sabe que é hora de subir o `timecrash` novamente!
- `timetogo`: finaliza normalmente depois de algum tempo.  Se você chamar `./immortal ./timetogo` é esperado que primeiramente apenas um processo filho seja criado. Depois de alguns segundos, o filho irá finalizar, então você sabe que é hora de subir o `timecrash` novamente!

## Como começar?

Faça uma primeira versão mais simples que inicializa o `programa` (mas não o reinicia). Depois, pense em como poderia:
- Verificar que ele terminou
- Reinicia-lo novamente

## Prazo
- Atividade do final da aula 15 https://insper.github.io/SistemasHardwareSoftware/aulas/15-exec/
- Prazo: https://insper.github.io/SistemasHardwareSoftware/sobre/

## Como entregar?
Para entregar a atividade, envie para o github suas alterações e suba uma tag com o padrão de nomenclatura `atv11.x.y`, substituindo `x` e `y` por qualquer número inteiro! Ex:

```
git tag -a atv11.0.0 -m "enviando a atv11.0.0"
git push origin atv11.0.0
```
