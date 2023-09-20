/*
0x0000000000000009 <+9>:     mov    %edi,%ebx
0x000000000000000b <+11>:    lea    0x8(%rsp),%rdx     -> int a;
0x0000000000000010 <+16>:    lea    0xc(%rsp),%rsi     -> int b;
0x0000000000000015 <+21>:    lea    0x0(%rip),%rdi        # 0x1c <ex4+28>
0x000000000000001c <+28>:    mov    $0x0,%eax
0x0000000000000021 <+33>:    call   0x26 <ex4+38>
0x0000000000000026 <+38>:    mov    0x8(%rsp),%edx
0x000000000000002a <+42>:    mov    0xc(%rsp),%eax
0x000000000000002e <+46>:    lea    (%rax,%rdx,2),%eax
0x0000000000000031 <+49>:    add    %ebx,%eax
0x0000000000000038 <+56>:    ret
*/

int ex4_solucao(int edi) {
    int a;
    int b;
    int eax = 0;
    scanf("%d %d", &a, &b);
    return edi + 2*b + a;
}
