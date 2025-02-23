%% Aula 11
%% Ex 1
s = tf('s');
C = 1;                  % Controlador
G = 25/(s*(s+5));       % Planta
Gma = C*G;              % F.T. de malha aberta
Gmf = feedback(Gma,1);  % Fechar uma malha que tem no ramo direto Gma 
                        % e realimentacao unitaria (H=1)
% Tambem eh possivel passar a malha direta como uma multiplicacao
% Gmf = feedback(C*G,1);

p_G = pole(G);      % polos da planta, que nesse caso tambem sao os polos de Gma
p_Gmf = pole(Gmf);  % polos de malha fechada

%% -----------------------------------------
% Diagrama de polos e zeros
figure(1)
pzmap(G);
hold on
pzmap(Gmf);
grid on;
hold off
legend('G','Gmf');

% perfumaria {
ax1 = gca;
ax1.XLim = [-6 1];
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

%% -----------------------------------------
% Resposta ao degrau unitario da F.T. de malha fechada
figure(2)
step(Gmf)
grid on

%% Ex 2

C2 = 0.7154;
Gma2 = C2*G;
Gmf2 = feedback(Gma2,1);
%% -----------------------------------------
% Diagrama de polos e zeros
figure(1)
pzmap(G);
hold on
pzmap(Gmf);
pzmap(Gmf2);
grid on;
hold off
% perfumaria {
ax1 = gca;
ax1.XLim = [-6 1];
ax1.YLim = [-5.5 5.5];
legend('G','Gmf','Gmf2')
%}

% perfumaria 2.0 {
a = findobj(ax1,'type','line'); % encontra todos os objetos do tipo linha em ax1
for i = 1:length(a) % estrutura de for para 'varrer'todos os objetos encontrados
    set(a(i),'markersize',12); % altera o tamanho do simbolo 'x'/'o' no pzmap
    set(a(i), 'linewidth',2);  % altera a espessura do simbolo 'x'/'o' no pzmap
end
clear a i % limpa as variaveis por preciosismo
%}

%% -----------------------------------------
% Resposta ao degrau unitario de Gmf e Gmf2
figure(2)
step(Gmf,Gmf2)  % resposta ao degrau com mais de um argumento
legend('Gmf','Gmf2')
grid on