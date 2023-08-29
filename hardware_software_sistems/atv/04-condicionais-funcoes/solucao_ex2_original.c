long vezes2(long a);

// 0x0000000000001132 <+0>:     endbr64
// 0x0000000000001136 <+4>:     push   %rbx
// 0x0000000000001137 <+5>:     mov    %rdi,%rbx
// 0x000000000000113a <+8>:     mov    %rsi,%rdi
// 0x000000000000113d <+11>:    call   0x1129 <vezes2>
// 0x0000000000001142 <+16>:    cmp    %rbx,%rax
// 0x0000000000001145 <+19>:    jle    0x114a <ex2+24>
// 0x0000000000001147 <+21>:    add    %rbx,%rbx
// 0x000000000000114a <+24>:    add    %rbx,%rax
// 0x000000000000114d <+27>:    pop    %rbx
// 0x000000000000114e <+28>:    ret

// 0x0000000000001129 <+0>:     endbr64
// 0x000000000000112d <+4>:     lea    (%rdi,%rdi,1),%rax
// 0x0000000000001131 <+8>:     ret

long solucao_ex2(long rdi, long rsi) {
    long rbx = rdi;
    rdi = rsi;
    long rax = vezes2(rdi);
    if (rax <= rbx) {
        goto label;
    }
    rbx += rbx;
    label:
    rax += rbx;
    return rax;
}
