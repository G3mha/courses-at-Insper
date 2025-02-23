%% Inicio
%define a fun��o de transfer�ncia 's'
s = tf('s');

% Define a fun��o de transfer�ncia da planta
Gplanta = 1/(s^2+10*s+20);

%% Controlador proporcional
% Abre uma nova figura
figure(1);
hold on;
title ('Controlador Proporcional');

% Ensaio com Kp=50
Kp = 50;
% Fun��o de transfer�ncia do controlador
C = Kp;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
axis([0 1.4000 0 1.3000]);
grid on;
title ('Controlador Proporcional');

% Ensaio com Kp=100
Kp = 100;
% Fun��o de transfer�ncia do controlador
C = Kp;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Proporcional');

% Ensaio com Kp=200
Kp = 200;
% Fun��o de transfer�ncia do controlador
C = Kp;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Proporcional');
legend('Kp=50', 'Kp=100', 'Kp=200')

%% Controlador derivativo
% Abre uma nova figura
figure(2);
hold on;
title ('Controlador Derivativo');
 
% Ensaio com Kp=200 e Kd = 0
Kp = 200; Kd = 0;
% Fun��o de transfer�ncia do controlador
C = Kp + Kd*s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
axis([0    1.4000         0    1.3000]);
grid on;
title ('Controlador Derivativo');

% Ensaio com Kp=200 e Kd = 10
Kp = 200; Kd = 10;
% Fun��o de transfer�ncia do controlador
C = Kp + Kd*s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Derivativo');

% Ensaio com Kp=200 e Kd = 20
Kp = 200; Kd = 20;
% Fun��o de transfer�ncia do controlador
C = Kp + Kd*s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Derivativo');
legend('Kp=200 e Kd=0', 'Kp=200 e Kd=10', 'Kp=200 e Kd=20')

% Ensaio com Kp=200 e Kd = 30
Kp = 200; Kd = 30;
% Fun��o de transfer�ncia do controlador
C = Kp + Kd*s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);

%% Controlador integrativo
% Abre uma nova figura
figure(3);
hold on;
title ('Controlador Integrativo');
 
% Ensaio com Kp=50 e Ki = 0
Kp = 50; Ki = 0;
% Fun��o de transfer�ncia do controlador
C = Kp + Ki/s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
axis([0    5.0000         0    1.6000]);
grid on;
title ('Controlador Integrativo');

% Ensaio com Kp=50 e Ki = 100
Kp = 50; Ki = 100;
% Fun��o de transfer�ncia do controlador
C = Kp + Ki/s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Integrativo');

% Ensaio com Kp=50 e Ki = 200
Kp = 50; Ki = 200;
% Fun��o de transfer�ncia do controlador
C = Kp + Ki/s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Integrativo');

% Ensaio com Kp=50 e Ki = 400
Kp = 50; Ki = 400;
% Fun��o de transfer�ncia do controlador
C = Kp + Ki/s;
%Fun��o de transfer�ncia de malha fechada
T = feedback(C*Gplanta, 1);
% Plota resposta ao degrau
step(T);
grid on;
title ('Controlador Integrativo');
legend('Kp=50 e Ki=0', 'Kp=50 e Ki=100', 'Kp=50 e Ki=200', 'Kp=50 e Ki=400');

