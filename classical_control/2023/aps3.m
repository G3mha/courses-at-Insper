%% Ex 3a
s = tf('s');
G = 50/(power(s,2)+10s+100);

figure;
step(5*G);        % Resposta gráfica temporal para uma entrada do tipo degrau
                % de amplitude 1, i.e., y(t) por t para x(t)= 1.
grid on