%% Aula 19
s = tf('s');
% FT de velocidade do motor
G_vel = zpk(17.4/(s+0.8));
% FT de posicao do motor
G_pos = zpk(17.4/(s*(s+0.8)));

%% Gmf
Kp = 1;
Gmf_vel = feedback(Kp*G_vel,1); 
Gmf_pos = feedback(Kp*G_pos,1);

%% Ex1: Malha de velocidade do motor
% Resposta ao degrau
figure(1)
step(Gmf_vel);
hold on
step(s/s,'--r'); % ``trick'' para plotar a referencia
hold off
% Resposta a rampa
figure(2)
step(Gmf_vel/s);
hold on
step(1/s,'--r');
hold off

%% Ex2: Malha de posicao do motor
% Resposta ao degrau
figure(3)
step(Gmf_pos);
hold on
step(s/s,'--r'); % ``trick'' para plotar a referencia
hold off
% Resposta a rampa
figure(4)
step(Gmf_pos/s);
hold on
step(1/s,'--r');
hold off

%% Ex3
s = tf('s');
G = zpk((s+2)/((s+3)*(s+4)));
K = 54;
C = K/s;
Gma = C*G;
Gmf = feedback(Gma,1);
% Resposta ao degrau
figure(1)
step(Gmf,5); % por 5s
hold on
step(tf([1],[1]),'--r'); % ``trick'' para plotar a referencia
hold off
%% Resposta a rampa
figure(2)
step(Gmf/s);
hold on
step(1/s,'--r');
hold off

%% Ex4
G = zpk((s+2)/(s*(s+3)*(s+4)));
K = 300;
C = K/s;
Gma = C*G;
Gmf = feedback(Gma,1);
% Resposta ao degrau
figure(3)
step(Gmf);
hold on
step(tf([1],[1]),'--r'); % ``new trick'' para plotar a referencia
hold off
% Resposta a rampa
figure(4)
step(Gmf/s);
hold on
step(1/s,'--r');
hold off