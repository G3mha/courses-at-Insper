all: exercicio

%.o: %.c 
	gcc -Og -fno-stack-protector -c $< -o $@

exercicio: corretor.o solucao.o
	gcc corretor.o solucao.o -o corretor -lsystemd
	@./corretor
	@rm corretor
	@rm solucao.o

.PHONY = all
