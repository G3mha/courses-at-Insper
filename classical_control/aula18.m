%% Resposta ao degrau para a malha de velocidade
s = tf('s');
G_vel = (-s+0.5)/(s^2+3*s+2);

Kp = 2; % vetor de ganhos Kp
t = 0:0.01:10; % vetor de tempo para melhorar a resolucao do grafico
figure(2)
hold on
for i=1:length(Kp) % for de 1 ate o tamanho do vetor Kp
    Gmf_vel(i) = feedback(Kp(i)*G_vel,1); % Gmf para cada ganho Kp
%     step(10*Gmf_vel(i)); % step de 10 para cada ganho Kp
    step(10*Gmf_vel(i),t); % step de 10 para cada ganho Kp
                            % com o vetor de tempo t
end
hold off
legend('K=2');