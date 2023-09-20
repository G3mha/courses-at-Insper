// 0x0000000000000114 <+0>:     sub    $0x1,%edx
// 0x0000000000000117 <+3>:     jmp    0x122 <funcao+14>
// 0x0000000000000119 <+5>:     neg    %eax
// 0x000000000000011b <+7>:     mov    %ax,(%rsi,%rcx,1)
// 0x000000000000011f <+11>:    sub    $0x1,%edx
// 0x0000000000000122 <+14>:    test   %edx,%edx
// 0x0000000000000124 <+16>:    js     0x13c <funcao+40>
// 0x0000000000000126 <+18>:    movslq %edx,%rax
// 0x0000000000000129 <+21>:    lea    (%rax,%rax,1),%rcx
// 0x000000000000012d <+25>:    movzwl (%rdi,%rax,2),%eax
// 0x0000000000000131 <+29>:    test   %ax,%ax
// 0x0000000000000134 <+32>:    jle    0x119 <funcao+5>
// 0x0000000000000136 <+34>:    mov    %ax,(%rsi,%rcx,1)
// 0x000000000000013a <+38>:    jmp    0x11f <funcao+11>
// 0x000000000000013c <+40>:    repz ret

void solucao(short *rdi, short *rsi, int edx){
    long rax, rcx;
    for (edx; edx >= 0; edx--){
        rax = (long) edx;
        rcx = 2 * rax;
        rax = *(rdi + rax);
        if (rax > 0) {
            *(rsi + rcx / 2) = rax;
        }
        if (rax <= 0){
            *(rsi + rcx / 2) = -rax;
        }
    }
    return;
}
