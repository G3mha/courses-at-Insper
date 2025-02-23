%% Ex 1a
s = tf('s');
G = 20/(0.1*s+1);

p = pole(G);             % polos de G
a = -p;
constante_de_tempo = 1/a;
tempo_de_acomodacao = 4/a;

%% Ex 1b
s = tf('s');
Gmf = 300/(s^2+10*s+300);

p_ex1b = pole(G);             % polos de G
pzmap(G)            % diagrama de polos e zeros de G
