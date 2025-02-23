%% Ex 1
s = tf('s');
G = (2*s+2)/(s^2*(s+3)*(s+5));

pole(G)             % polos de G
zero(G)             % zeros de G
[z,p,k]=zpkdata(G)  % alternativa para extrair zeros, polos e ganho de G

pzmap(G)            % diagrama de polos e zeros de G
xlim(gca,[-6 1])    % altera os limites do eixo X para de -6 a 1 (opcional)
                        % gca: get current axis (opcional)
grid on             % ativa as grandes de fundo (opcional)

%% Ex 2
s = tf('s');
G = 5/(s^2+4*s+8);

pole(G)             % polos de G
zero(G)             % zeros de G

figure;             % cria uma nova figura para nao sobrescrever (opcional)
pzmap(G)            % diagrama de polos e zeros de G
ax = gca;           
ax.XLim = [-3 0.5]; % forma alternativa de alterar os limites dos eixos
ax.YLim = [-3 3];
ax.XGrid = 'on';    % grades de fundo cartesianas em X (opcional)
ax.YGrid = 'on';    % grades de fundo cartesianas em Y (opcional)

%% Ex 3
s = tf('s');
G = 1/(s+20);

figure;
step(2*G);      % Resposta gráfica temporal para uma entrada do tipo degrau
                % de amplitude 2, i.e., y(t) por t para x(t)= 2.
grid on