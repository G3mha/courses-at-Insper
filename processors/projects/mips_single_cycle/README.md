# Resultados da Execução: Ciclo Único com Conjuntos A e B + SLL + SRL + SB

| Line   | PC Hex | Saída ULA  | Instrução           | Comentário         |
|:-------|:-------|:-----------|:--------------------|:-------------------|
| 00     | 0x00   | 0x00000008 | sw $t1 8($zero)     | M(8) := 0x0000000A |
| 01     | 0x04   | 0x00000008 | lw $t0 8($zero)     | $t0 := 0x0000000A  |
| 02     | 0x08   | 0xFFFFFFFF | sub $t0 $t1 $t2     | $t0 := 0xFFFFFFFF  |
| 03     | 0x0C   | 0x0000000A | and $t0 $t1 $t2     | $t0 := 0x0000000A  |
| 04     | 0x10   | 0x0000000B | or $t0 $t1 $t2      | $t0 := 0x0000000B  |
| 05     | 0x14   | 0xXXXXXXXX | lui $t0 0xFFFF      | $t0 := 0xFFFF0000  |
| 06     | 0x18   | 0x00000014 | addi $t0 $t1 0x000A | $t0 := 0x00000014  |
| 07     | 0x1C   | 0x00000010 | andi $t0 $t0 0x0013 | $t0 := 0x00000010  |
| 08     | 0x20   | 0x0000000F | ori $t0 $t4 0x0007  | $t0 := 0x0000000F  |
| 09     | 0x24   | 0x00000000 | slti $t0 $t1 0xFFFF | $t0 := 0x00000000  |
| 10     | 0x28   | 0x0000000B | add $t0 $t0 $t2     | $t0 := 0x0000000B  |
| 11     | 0x2C   | 0xFFFFFFF5 | bne $t0 $t5 0xFFFE  | pc := 0x28         |
| 10     | 0x28   | 0x00000016 | add $t0 $t0 $t2     | $t0 := 0x00000016  |
| 11     | 0x2C   | 0x00000000 | bne $t0 $t5 0xFFFE  | pc := 0x30         |
| 12     | 0x30   | 0x00000001 | slt $t0 $t1 $t2     | $t0 := 0x00000001  |
| 13     | 0x34   | 0x0000000C | add $t0 $t0 $t2     | $t0 := 0x0000000C  |
| 14     | 0x38   | 0x00000000 | beq $t0 $t3 0xFFFE  | pc := 0x34         |
| 13     | 0x34   | 0x00000017 | add $t0 $t0 $t2     | $t0 := 0x00000017  |
| 14     | 0x38   | 0x0000000B | beq $t0 $t3 0xFFFE  | pc := 0x3C         |
| 15     | 0x3C   | 0xXXXXXXXX | jal 0x00001F        | jmp to 31          |
| 31     | 0x7C   | 0x0000000B | nor $t0 $t6 $t7     | $t0 := 0x0000000C  |
| 32     | 0x80   | 0xXXXXXXXX | sll $s2 $s2 $s3     | $s2 := 0x00000010  |
| 33     | 0x84   | 0xXXXXXXXX | srl $s2 $s2 $s2     | $s2 := 0x00000010  |
| 34     | 0x88   | 0xXXXXXXXX | jr $ra              | pc := #17          |
| 17     | 0x44   | 0xXXXXXXXX | j 0x000000          | Volta ao começo    |
