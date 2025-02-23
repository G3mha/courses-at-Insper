%% EX 2 
close all
clear all
clc

s = tf('s');
G = (s+2)/(s*(s-10));

K = [1 2 3 4 5 10 15 20]; % vetor com valores para K

figure(1);
hold on;

for n=1:8   % estrutura de for
    Gmf(n) = feedback(K(n)*G,1);% Gmf(i) para cada K(i)   
    figure(1);
    pzmap(Gmf(n));% diagram de polos e zeros para cada Gmf(i)
end
legend('K=1','K=2','K=3','K=4','K=5','K=10','K=15','K=20');
hold off

% perfumaria {
ax1 = gca;
ax1.XLim = [-7 10];
ax1.YLim = [-5.5 5.5];
%}

% outra forma de alterar o tamanho do simbolo e a espessura da linha
% perfumaria 2.0 {   
a = findobj(ax1,'type','line'); % encontra todos os objetos do tipo linha em ax1
for i = 1:length(a) % estrutura de for para 'varrer'todos os objetos encontrados
    set(a(i),'markersize',12); % altera o tamanho do simbolo 'x'/'o' no pzmap
    set(a(i), 'linewidth',2);  % altera a espessura do simbolo 'x'/'o' no pzmap
end
clear a i % limpa as variaveis por preciosismo
%}

%% -----------------------------------------------------
% O Matlab possui uma função própria para fazer isso!
figure(2)
rlocus(G)

%% -----------------------------------------------------
% Mas o que acontece com a resposta ao degrau quando os
% os polos estão no semiplano direito? 

% Quando K=15, com os polos no semiplano esquerdo...
figure(3)
step(Gmf(7))

% Mas quando K=5, com os polos no semiplano direito, o que
% acontece?
figure(4)
step(Gmf(5))