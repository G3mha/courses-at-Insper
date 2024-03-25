all: exercicio

%.o: %.c 
	gcc -Og -fno-stack-protector -c $< -o $@

exercicio: corretor.o solucao.o
	gcc corretor.o solucao.o -o corretor
	@./corretor && echo "Todos os testes passaram!" || true
	@rm corretor

.PHONY = all
