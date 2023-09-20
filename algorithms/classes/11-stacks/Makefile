CC=gcc
CFLAGS=-Wall -pedantic -std=c99 -O0 -g
LFLAGS=
OBJCMD=$(CC) $(CFLAGS) $< -c
EXECMD=$(CC) $^ -o $@ $(LFLAGS)
OBJS=stack_int.o queue_int.o stack_int_test.o queue_int_test.o
EXEC=stack_int_test queue_int_test

all: $(EXEC)

stack_int.o: stack_int.c stack_int.h
	$(OBJCMD)

queue_int.o: queue_int.c queue_int.h
	$(OBJCMD)

stack_int_test.o: stack_int_test.c stack_int.h mintest/macros.h mintest/runner.h
	$(OBJCMD)

queue_int_test.o: queue_int_test.c queue_int.h mintest/macros.h mintest/runner.h
	$(OBJCMD)

stack_int_test: stack_int_test.o stack_int.o
	$(EXECMD)

queue_int_test: queue_int_test.o queue_int.o
	$(EXECMD)

clean:
	rm -f $(OBJS)

destroy: clean
	rm -f $(EXEC)
