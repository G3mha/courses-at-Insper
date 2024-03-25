// 0x0000000000000000 <+0>:     endbr64
// 0x0000000000000004 <+4>:     mov    $0x0,%ecx
// 0x0000000000000009 <+9>:     mov    $0x0,%r8d
// 0x000000000000000f <+15>:    jmp    0x15 <ex3+21>
// 0x0000000000000011 <+17>:    add    $0x1,%rcx
// 0x0000000000000015 <+21>:    cmp    %rdi,%rcx
// 0x0000000000000018 <+24>:    jge    0x2c <ex3+44>
// 0x000000000000001a <+26>:    mov    %rcx,%rax
// 0x000000000000001d <+29>:    cqto
// 0x000000000000001f <+31>:    idiv   %rsi
// 0x0000000000000022 <+34>:    test   %rdx,%rdx
// 0x0000000000000025 <+37>:    jne    0x11 <ex3+17>
// 0x0000000000000027 <+39>:    add    %rcx,%r8
// 0x000000000000002a <+42>:    jmp    0x11 <ex3+17>
// 0x000000000000002c <+44>:    mov    %r8,%rax
// 0x000000000000002f <+47>:    ret

long ex3_solucao(long rdi, long rsi){
    int ecx = 0x0;
    long rcx = (long) ecx;
    long r8 = 0x0;
    long rax;
    goto line21;
    line17:
    rcx += 0x1;
    line21:
    if (rcx >= rdi) goto line44;
    rax = rcx;
    if ((rax % rsi) != 0) goto line17;
    r8 += rcx;
    goto line17;
    line44:
    rax = r8;
    return rax;
}
