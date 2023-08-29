all: ex1 ex2 ex3 ex4

%.o: %.c
	gcc -Og -fno-stack-protector -c $< -o $@

ex1: ex1.o solucao_ex1.o
	@echo "--------------------------"
	@echo "# Testando ex1"
	gcc solucao_ex1.o ex1.o -o ex1
	@./ex1 && echo "Todos os testes passaram!" || true
	@rm ex1
	@rm solucao_ex1.o

ex2: ex2.o solucao_ex2.o
	@echo "--------------------------"
	@echo "# Testando ex2"
	gcc solucao_ex2.o ex2.o -o ex2
	@./ex2 && echo "Todos os testes passaram!" || true
	@rm ex2
	@rm solucao_ex2.o

ex3: ex3.o solucao_ex3.o
	@echo "--------------------------"
	@echo "# Testando ex3"
	gcc solucao_ex3.o ex3.o -o ex3
	@./ex3 && echo "Todos os testes passaram!" || true
	@rm ex3
	@rm solucao_ex3.o

ex4: ex4.o solucao_ex4.o
	@echo "--------------------------"
	@echo "# Testando ex4"
	gcc solucao_ex4.o ex4.o -o ex4
	@./ex4 && echo "Todos os testes passaram!" || true
	@rm ex4
	@rm solucao_ex4.o

.PHONY = all
