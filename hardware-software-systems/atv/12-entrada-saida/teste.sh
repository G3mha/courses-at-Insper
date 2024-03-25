#!/bin/bash

gcc tirar_comentarios.c -o tirar_comentarios
v=$(valgrind --leak-check=yes ./tirar_comentarios 2>&1 | grep "ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)")
if [ "$v" = "" ]; then
	echo "Problemas acusados pelo Valgrind..."
	exit -1
else
	echo "Passou no Valgrind."
fi

casos=5
cont=0
for((i=1; i<=$casos; i++))
do	
	./tirar_comentarios caso$i.c resp_caso$i.c
	x=$(diff -Bw gabarito.c resp_caso$i.c 2>&1)

	echo $x
	if [ "$x" = "" ]; then
		cont=$(expr $cont + 1)
		echo 'Passou' $cont'/'$casos
	else
		echo 'Erro' $cont'/'$casos
	fi
done
