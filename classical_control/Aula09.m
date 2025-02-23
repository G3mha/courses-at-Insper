%% Aula 09
s = tf('s');
% ------------------------------------------------------------------------
%% Caso 1
% R = 3;
R = 3;
G = 9/(s^2+3*R*s+9);

%% Diagrama de polos e zeros
figure(1) % cria uma nova figura e forca ser a de numero 1
pzmap(G);

lgdpz = legend('Caso 1'); % criar legenda e atribui a uma variavel para alterar posteriormente

% perfumaria {
ax1 = gca;
ax1.XLim = [-12 0.5];
ax1.YLim = [-4 4];
ax1.XGrid = 'on';
ax1.YGrid = 'on';
ax1.Children(1).Children(1).MarkerSize = 12;	% altera o tamanho do simbolo 'o' no gráfico
ax1.Children(1).Children(2).MarkerSize = 12;    % altera o tamanho do simbolo 'x' no gráfico
ax1.Children(1).Children(1).LineWidth=2;        % altera a espessura do simbolo 'o' no gráfico
ax1.Children(1).Children(2).LineWidth=2;        % altera a espessura do simbolo 'x' no gráfico
% }
%% Resposta ao degrau unitario
figure(2) % cria uma nova figura e forca ser a de numero 2
step(G);
lgdst = legend('Caso 1');

% perfumaria {
ax2 = gca;
ax2.XLim = [0 8];
grid on;
% }

% ------------------------------------------------------------------------
%% Caso 2
% R = 2;
R = 2;
G = 9/(s^2+3*R*s+9);

%% Diagrama de polos e zeros
figure(1)   % forca utilizar a figura de numero 1
hold on     % mantem o que já existe no grafico atual
pzmap(G);   % adiciona os polos e zeros na figura 1
hold off    % desabilita adicionar ao grafico atual

% perfumaria {
ax1.Children(1).Children(1).MarkerSize = 12;
ax1.Children(1).Children(2).MarkerSize = 12;
ax1.Children(1).Children(1).LineWidth=2;
ax1.Children(1).Children(2).LineWidth=2;
% }

lgdpz.String{2} = 'Caso 2';   % adiciona o Caso 2 a legenda existente
%% Resposta ao degrau unitario
figure(2)   % forca utilizar a figura de numero 2
hold on
step(G);    % adiciona a resposta ao degrau na figura 2
hold off
lgdst.String{2} = 'Caso 2';
% ------------------------------------------------------------------------
%% Caso 3
% R = 0.5;
R = 0.5;
G = 9/(s^2+3*R*s+9);

%% Diagrama de polos e zeros
figure(1)
hold on
pzmap(G);
hold off

% perfumaria {
ax1.Children(1).Children(1).MarkerSize = 12;
ax1.Children(1).Children(2).MarkerSize = 12;
ax1.Children(1).Children(1).LineWidth=2;
ax1.Children(1).Children(2).LineWidth=2;
% }

lgdpz.String{3} = 'Caso 3';   % adiciona o Caso 3 a legenda existente
%% Resposta ao degrau unitario
figure(2)
hold on
step(G);
hold off
lgdst.String{3} = 'Caso 3';
% ------------------------------------------------------------------------
%% Caso 4
% R = 0;
R = 0;
G = 9/(s^2+3*R*s+9);

%% Diagrama de polos e zeros
figure(1)
hold on
pzmap(G);
hold off

% perfumaria {
ax1.Children(1).Children(1).MarkerSize = 12;
ax1.Children(1).Children(2).MarkerSize = 12;
ax1.Children(1).Children(1).LineWidth=2;
ax1.Children(1).Children(2).LineWidth=2;
% }
lgdpz.String{4} = 'Caso 4';   % adiciona o Caso 4 a legenda existente
%% Resposta ao degrau unitario
figure(2)
hold on
step(G);
hold off
lgdst.String{4} = 'Caso 4';