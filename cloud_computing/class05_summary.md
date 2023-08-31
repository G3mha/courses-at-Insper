# Cloud Computing - Class 04 - Internet Protocol

## IP Address - Subnets

Conceito de máscaras de subrede (*deprecated* em 2006):

São 4 octetos. Cada octeto tem 8 bits. Cada bit pode ser 0 ou 1. Portanto, cada octeto pode assumir 256 valores (0-255). Os octetos tem que ser preenchidos sequencialmente por 1, que correspondem ao endereço da rede, e ao momento que aparece o 0 até o final, denota o endereço do *host*.

**Máscara é para declarar o que é rede e o que é host!**

*Ex:*

    128 | 64  | 32  | 16  |  8  |  4  |  2  |  1
    2^7 | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0

- classe A: 255.0.0.0 (/8)
    -> para configurar deve-se começar com `10.`

- classe B: 255.255.0.0 (/16)
    -> para configurar deve-se começar com `172.16` até `172.31`

- classe C: 255.255.255.0 (/24)
    -> para configurar deve-se começar com `192.168`

São portanto, 2^32 endereços possíveis, ou 4.294.967.296 endereços. O que não atende à demanda atual.

## Possíveis soluções para o gargalo de endereços

- IPv6 (128 bits) -> 2^128 endereços possíveis, ou seja, muito mais possibilidades

## Redes privadas (NAT)

*source Network Address Translation* (sNAT):

1. Verifica se está na mesma rede, se sim, envia para aquela máquina.

2. Caso não esteja na mesma rede, envia para o gateway, que verifica se o endereço é válido, se sim, envia para a internet, se não, retorna erro.

3. Ao enviar para a internet, o gateway (que costuma ser, mas nem sempre é, o roteador) troca o endereço de origem pelo seu próprio endereço, e guarda o endereço original em uma tabela, portanto é uma relação de N:1 (N endereços privados para 1 endereço público).

O mesmo é válido para o (dNAT) *destination Network Address Translation*, só que neste caso, o dNAT é feito pelo roteador da internet (em um caminho reverso), que recebe o pacote, verifica se o endereço de destino é válido, se sim, envia para o gateway, que verifica se o endereço é válido, se sim, envia para a máquina destino, se não, retorna erro.

## A "Tabela do Mestre"

| Rede | Range      | Broadcast
| ---  | --------   | ---
| 0    | 1 -> 14    | 15
| 16   | 17 -> 30   | 31
| 32   | 33 -> 46   | 47
| 48   | 49 -> 62   | 63
| 64   | 65 -> 78   | 79
| 80   | 81 -> 94   | 95
| 96   | 95 -> 110  | 111
| 112  | 113 -> 126 | 127
| 128  | 129 -> 142 | 143
| 144  | 145 -> 158 | 159
| 160  | 161 -> 174 | 175
| 176  | 177 -> 190 | 191
| 192  | 193 -> 206 | 207
| 208  | 209 -> 222 | 223
| 224  | 225 -> 238 | 239
| 240  | 241 -> 254 | 255
