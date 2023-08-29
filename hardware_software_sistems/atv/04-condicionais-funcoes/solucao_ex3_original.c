// 0x0000000000000000 <+0>:     endbr64
// 0x0000000000000004 <+4>:     cmp    %rsi,%rdi
// 0x0000000000000007 <+7>:     setl   %al
// 0x000000000000000a <+10>:    movzbl %al,%eax
// 0x000000000000000d <+13>:    mov    %eax,(%rdx)
// 0x000000000000000f <+15>:    sete   %al
// 0x0000000000000012 <+18>:    movzbl %al,%eax
// 0x0000000000000015 <+21>:    mov    %eax,(%rcx)
// 0x0000000000000017 <+23>:    setg   %al
// 0x000000000000001a <+26>:    movzbl %al,%eax
// 0x000000000000001d <+29>:    mov    %eax,(%r8)
// 0x0000000000000020 <+32>:    ret

void solucao_ex3(long rdi, long rsi, int *rdx, int *rcx, int *r8){
    char al = rdi < rsi;
    int eax = (int) al;
    *rdx = eax;
    al = rdi == rsi;
    eax = (int) al;
    *rcx = eax;
    al = rdi > rsi;
    eax = (int) al;
    *r8 = eax;
}
