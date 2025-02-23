% Modelagem e Controle 
% AULA 02
% C. Menegaldo, 08/22

%% Exemplo 01 - Plot
Vs = 10;    % 10 V
R = 100;    % 100 Ohm
C = 0.01;   % 10 mF

t = 0:0.001:10;

ic = Vs/R*(exp(-t/(R*C))).*1000;
vc = Vs*(1-exp(-t/(R*C)));

figure
plot(t,ic);
grid on;
xlabel('Tempo (s)')
ylabel('Corrente (mA)')

figure
plot(t,vc);
grid on;
xlabel('Tempo (s)')
ylabel('Tensão no capacitor (V)')

%% Exemplo 01 - Symbolic Math
%clear Vs R C t vc % remover essas variáveis
clear all

syms Vs t R C
syms ic(t) vc(t)

% Corrente
odei = R*diff(ic(t),t) + ic(t)/C == 0;
condi = ic(0) == Vs/R;

i_sol = dsolve(odei,condi);

i_sol_n = subs(i_sol,{R C Vs},{100 0.01 10});

pretty(odei)
pretty(condi)
pretty(i_sol)
pretty(i_sol_n)

figure
fplot(i_sol_n,[0 10])
grid on

% Tensão
odev = R*C*diff(vc(t),t) + vc(t) -Vs == 0;
condv = vc(0) == 0;

v_sol = dsolve(odev,condv);

v_sol_n = subs(v_sol,{R C Vs},{100 0.01 10});

pretty(odev)
pretty(condv)
pretty(v_sol)
pretty(v_sol_n)

figure
fplot(v_sol_n,[0 10])
grid on