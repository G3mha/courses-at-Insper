// Questao 04
// Implemente aqui uma funcao chamada ex4_solucao
/*
   0x00000000000013ee <+0>:     endbr64
   0x00000000000013f2 <+4>:     mov    %rdi,%r11
   0x00000000000013f5 <+7>:     mov    %rsi,%r10
   0x00000000000013f8 <+10>:    mov    %edx,%r9d
   0x00000000000013fb <+13>:    mov    $0x0,%eax
   0x0000000000001400 <+18>:    jmp    0x1405 <ex4+23>
   0x0000000000001402 <+20>:    add    $0x1,%eax
   0x0000000000001405 <+23>:    movslq %eax,%rdx
   0x0000000000001408 <+26>:    cmp    %r10,%rdx
   0x000000000000140b <+29>:    jge    0x142d <ex4+63>
   0x000000000000140d <+31>:    movslq %eax,%rdx
   0x0000000000001410 <+34>:    lea    (%r11,%rdx,4),%rsi
   0x0000000000001414 <+38>:    mov    (%rsi),%edx
   0x0000000000001416 <+40>:    mov    %r9d,%edi
   0x0000000000001419 <+43>:    sub    %ecx,%edi
   0x000000000000141b <+45>:    cmp    %edi,%edx
   0x000000000000141d <+47>:    jl     0x1402 <ex4+20>
   0x000000000000141f <+49>:    lea    (%r9,%rcx,1),%edi
   0x0000000000001423 <+53>:    cmp    %edi,%edx
   0x0000000000001425 <+55>:    jg     0x1402 <ex4+20>
   0x0000000000001427 <+57>:    mov    %eax,(%r8)
   0x000000000000142a <+60>:    mov    (%rsi),%eax
   0x000000000000142c <+62>:    ret
   0x000000000000142d <+63>:    movl   $0xffffffff,(%r8)
   0x0000000000001434 <+70>:    mov    $0x0,%eax
   0x0000000000001439 <+75>:    ret
*/

int ex4_solucao(long rdi, long rsi, long rdx, long rcx) {
    long r11 = rdi;
    long r10 = rsi;
    long r9d = rdx;
    int eax = 0;
    goto line23;
    line20:
    eax++;
    line23:
    rdx = (long) eax;
    if (rdx >= r10) goto line63;
    rdx = (long) eax;
    rsi = (4*rdx)+r11;
    rdx = *(long*)rsi;
    rdi = r9d;
    rdi -= rcx;
    if (rdx < rdi) goto line20;
    rdi = rcx + r9d;
    if (rdx > rdi) goto line20;
    *()r8 = rdx;
    line63:




    while (1) {
        rdx = eax;
        if (rsi >= rdx) {
            eax = 0;
            break;
        }
        rdx = eax;
        rsi = (4*rdx) + r11;

        rdx = *r10;
        rdi = r9d;
        rdi -= rcx;
        eax++;
        if (rdi < rdx) {
            continue;
        }
        rdi = rcx + r9d;
        if (rdi > rdx) {
            continue;
        }
        else {
            eax = rsi;
            break;
        }
    }
    return eax;
}