# Projeto Embarcados

Desenvolvendo um controle remoto para o aplicativo spotify

## Entrega 1

### Integrantes

- Enricco Gemha
- Guilherme Fontana Louro

### Ideia

Protótipo de interface física capaz de tocar músicas no spotify e controlar certas saídas digitais físicas. Podendo pular, voltar e pausar a música, além de um controle para o volume.

### Nome

Spotify Controller

### Usuários 

Donos de computador que gostariam de controlar seu computador (ênfase no spotify) usando um controle.

### Software/Jogo 

Spotify.

### Jornada do usuários (3 pts)

Jornada 1:
O usuário liga o "Spotify Controller" utilizando o botão de liga/desliga, após isso, ele utiliza o botão de play/pause para que uma música seja tocada no serviço spotify. A música é tocada e o usuário resolve avançar a música utilizando o botão de avançar. Após isso, ele se arrepende e retorna para a música anterior usando o botão de voltar.

Jornada 2:
O usuário liga o "Spotify Controller" utilizando o botão de liga/desliga, após isso, ele utiliza o botão de play/pause para que a música seja tocada no serviço spotify. A música está tocando em um som muito baixo, portanto, o usuário usa o controlador de volume para aumentar o volume ao máximo. Após alguns minutos, ele recebe uma ligação no teams, utilizando do mesmo controlador de volume para abaixar o volume do spotify e poder escutar sua chamada.
### Comandos/ Feedbacks (2 pts)

<!-- 
Quais são os comandos/ operacões possíveis do seu controle?

Quais os feedbacks que seu controle vai fornecer ao usuário?
-->

**Comandos**:
- **Botão power**: liga o dispositivo e pareia no bluetooth.      
- **Scroll de volume**: um botão de scroll capaz de alterar o volume do aplicativo spotify.
- **Botões coloridos(3)**: Estes botões controlarão o spotify nas funções de passar e voltar de música e pause/play.

**Feedbacks**:
- O botão power da feedback para o usuário sobre o pareamento com as luzes presentes nele, ele ficará piscando até que o pareamento seja concluído.

## In/OUT (3 pts)

<!--
Para cada Comando/ Feedback do seu controle, associe qual sensores/ atuadores pretende utilizar? Faca em formato de lista, exemplo:

**In**:
1) **Botão** de ligar/desligar (power) (botao com o led);
2) **Botão** de pause/play da música;
3) **Botão** de avançar música;
4) **Botão** de retroceder música;
5) **scroll** de alterar volume.

**Out**:
1) **Led** para indicar funcionamento do sistema e conexão bluetooth.

### Design (2 pts)

<!--
Faca um esboco de como seria esse controle (vai ter uma etapa que terão que detalhar melhor isso).
-->

!["Imagem do protótipo"](design.jpeg)
