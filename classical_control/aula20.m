%% Aula 20
%% Ex 1a
clear all
s = tf('s');
% FT de velocidade do motor
G_vel = zpk(17.4/(s+0.8));

Mp = 0.02;
Tp = 1;
zeta = sqrt((log(Mp)^2)/(pi^2+log(Mp)^2));
wn = pi/(Tp*sqrt(1-zeta^2));

Ki = wn^2/17.4;
Kp = (2*zeta*wn-0.8)/17.4;

C = Kp + Ki/s;
Gmf_vel = feedback(C*G_vel,1);
step(Gmf_vel)
grid on

%% Influencia do Kp

Kp_vec = [0.2 0.3 0.4 0.5 0.6 0.7];
Ki = 1.4468;

figure(2)
hold on
for i=1:length(Kp_vec)
    C = Kp_vec(i) + Ki/s;
    Gmf_vel = feedback(C*G_vel,1);
    step(Gmf_vel)
end
hold off
grid on
legend(strcat('Ki = 1.4 e Kp=',num2str(Kp_vec')));

%% Influencia do Ki

Kp = 0.4;
Ki_vec = [0.0 0.1 0.4 0.8 1.6 3.2];

figure(2)
hold on
for i=1:length(Ki_vec)
    C = Kp + Ki_vec(i)/s;
    Gmf_vel = feedback(C*G_vel,1);
    step(Gmf_vel)
    stepinfo(Gmf_vel)
end
hold off
grid on
legend(strcat('Kp = 0.4 e Ki=',num2str(Ki_vec')));

%% Ajuste fino do ex 1a
Ki = wn^2/17.4;
Kp = (2*zeta*wn-0.8)/17.4;

C_orig = Kp + Ki/s;
Gmf_vel_orig = feedback(C_orig*G_vel,1);

Ki2 = 0.3*Ki;
Kp2 = Kp;

C_tuned = Kp2 + Ki2/s;
Gmf_vel_tuned = feedback(C_tuned*G_vel,1);
step(Gmf_vel_orig,Gmf_vel_tuned)
grid on
legend('original','ajustada')

%% Ajuste fino do ex 1a (2)
Ki = 17.4/wn^2;
Kp = (2*zeta*wn-0.8)/17.4;

C_orig = Kp + Ki/s;
Gmf_vel_orig = feedback(C_orig*G_vel,1);

Ki2 = Ki;
Kp2 = 1.5*Kp;

C_tuned = Kp2 + Ki2/s;
Gmf_vel_tuned = feedback(C_tuned*G_vel,1);
step(Gmf_vel_orig,Gmf_vel_tuned)
grid on
legend('original','ajustada')

%% Ex 1b
s = tf('s');
% FT de posicao do motor
G_pos = zpk(17.4/(s*(s+0.8)));

Mp = 0.02;
Tp = 0.4;
zeta = sqrt((log(Mp)^2)/(pi^2+log(Mp)^2));
wn = pi/(Tp*sqrt(1-zeta^2));

Kp = wn^2/17.4;
Kd = (2*zeta*wn-0.8)/17.4;

Gmf_pos = 17.4*Kp/(s^2 + s*(0.8 + 17.4*Kd) + 17.4*Kp);
step(Gmf_pos)
grid on

%% Influencia do Kp

Kp = [9 10 12 14 16];
Kd = 1;

figure(2)
hold on
for i=1:length(Kp)
    Gmf_pos = 17.4*Kp(i)/(s^2 + s*(0.8 + 17.4*Kd) + 17.4*Kp(i));
    step(Gmf_pos);
end
hold off
grid on
legend(strcat('Kd=1 e Kp=',num2str(Kp')));

%% Influencia do Kd

Kp = 9;
Kd_vec = [0.2 0.4 0.6 0.8 1];
figure(1)
hold on
for i=1:length(Kd_vec)
    Gmf_pos = 17.4*Kp/(s^2 + s*(0.8 + 17.4*Kd_vec(i)) + 17.4*Kp);
    step(Gmf_pos);
end
hold off
grid on
legend(strcat('Kp = 9 e Kd=',num2str(Kd_vec')));