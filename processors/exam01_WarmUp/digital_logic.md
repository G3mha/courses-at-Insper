# Digital Logic

## Combinational Logic

### Exercise 1

f = (not(a) and not(c)) or b
<a,b,c> = <1,1,0>

f<1,1,0> = (not(1) and not(0)) or 1 = 1

Answer: 1 (High logic value)

### Exercise 2

*I can't comprehend!*

### Exercise 3

- Typical delay for logic gates:

| Gate | Delay (t.u.) |
| --- | --- |
| AND | 3 |
| OR | 4 |
| NOT | 1 |

- Truth table:

| A and B | C and D | Y |
| --- | --- | --- |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

So we can perceive that the Y output is a result of the A and B input, therefore, it is a minimized circuit. So, the delay is 3 t.u.

### Exercise 4

a. Boolean algebra: $L = I \cdot D \cdot \bar{B}$

b. Truth table:

| $I$ | $D$ | $B$ | $L$ |
| --- | --- | --- | --- |
| 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 |
| 1 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 1 | 1 | 0 |
