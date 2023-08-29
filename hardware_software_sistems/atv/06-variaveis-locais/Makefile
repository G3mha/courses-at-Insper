
%.o: %.c
	gcc -Og -fno-stack-protector -c $< -o $@


all: ex4.o solucao_ex4.c ex5.o solucao_ex5.c
	@echo "Testando ex4:"
	@gcc -fno-stack-protector -Og solucao_ex4.c ex4.o -o ex4 2> /dev/null && ./ex4
	
	@echo "Testando ex5:"
	@gcc -fno-stack-protector -Og solucao_ex5.c ex5.o -o ex5 2> /dev/null && ./ex5
