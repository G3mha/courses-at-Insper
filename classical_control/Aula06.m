%% Ex 2
syms s Y(s)
Y = 12/(s^2*(s+2));
partfrac(Y)

%% Funcao de transferencia
clear s Y

% Ex 4
num = [4 3];
den = [1 3 5];
G = tf(num,den);
% ou
s = tf('s')
G = (4*s + 3)/(s^2+3*s+5)

%% Resposta ao impulso
figure(1)
impulse(G,10)
grid on

%% Resposta ao degrau
figure(2)
step(G)
grid on