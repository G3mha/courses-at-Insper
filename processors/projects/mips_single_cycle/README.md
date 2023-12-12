# Resultados da Execução: Ciclo Único com Conjuntos A e B + SLL + SRL + SB

| PC Dec | PC Hex | Saída ULA  | Instrução           | Comentário         |
|:-------|:-------|:-----------|:--------------------|:-------------------|
| 00     | 0x00   | 0x00000008 | sw $t1 8($zero)     | M(8) := 0x0000000A |
| 04     | 0x04   | 0x00000008 | lw $t0 8($zero)     | $t0 := 0x0000000A  |
| 08     | 0x08   | 0xFFFFFFFF | sub $t0 $t1 $t2     | $t0 := 0xFFFFFFFF  |
| 12     | 0x0C   | 0x0000000A | and $t0 $t1 $t2     | $t0 := 0x0000000A  |
| 16     | 0x10   | 0x0000000B | or $t0 $t1 $t2      | $t0 := 0x0000000B  |
| 20     | 0x14   | 0xXXXXXXXX | lui $t0 0xFFFF      | $t0 := 0xFFFF0000  |
| 24     | 0x18   | 0x00000014 | addi $t0 $t1 0x000A | $t0 := 0x00000014  |
| 28     | 0x1C   | 0x00000010 | andi $t0 $t0 0x0013 | $t0 := 0x00000010  |
| 32     | 0x20   | 0x0000000F | ori $t0 $t4 0x0007  | $t0 := 0x0000000F  |
| 36     | 0x24   | 0x00000000 | slti $t0 $t1 0xFFFF | $t0 := 0x00000000  |
| 40     | 0x28   | 0x0000000B | add $t0 $t0 $t2     | $t0 := 0x0000000B  |
| 44     | 0x2C   | 0xFFFFFFF5 | bne $t0 $t5 0xFFFE  | pc := 0x28         |
| 40     | 0x28   | 0x00000016 | add $t0 $t0 $t2     | $t0 := 0x00000016  |
| 44     | 0x2C   | 0x00000000 | bne $t0 $t5 0xFFFE  | pc := 0x30         |
| 48     | 0x30   | 0x00000001 | slt $t0 $t1 $t2     | $t0 := 0x00000001  |
| 52     | 0x34   | 0x0000000C | add $t0 $t0 $t2     | $t0 := 0x0000000C  |
| 56     | 0x38   | 0x00000000 | beq $t0 $t3 0xFFFE  | pc := 0x34         |
| 52     | 0x34   | 0x00000017 | add $t0 $t0 $t2     | $t0 := 0x00000017  |
| 56     | 0x38   | 0x0000000B | beq $t0 $t3 0xFFFE  | pc := 0x3C         |
| 60     | 0x3C   | 0xXXXXXXXX | jal 0x00001F        | << 0x1F := 0x7C    |
| 12     | 0x7C   | 0xXXXXXXXX | jr $ra              | pc := 0x40         |
| 64     | 0x40   | 0xXXXXXXXX | nop                 |                    |
| 68     | 0x44   | 0xXXXXXXXX | j 0x000000          | Volta ao Início    |
