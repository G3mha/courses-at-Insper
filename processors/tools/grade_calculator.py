from functools import reduce

ai = 6
af = 8.5
qs = [7,8,3,10,6,10]
qs_med = reduce(lambda x, y: x + y, qs) / len(qs)
p1i = 10
p1f = 4
p2i = 10
p2f = 10 # espero :)

nf = (0.18*qs_med)+(0.18*ai)+(0.24*af)+(0.06*p1i)+(0.1*p1f)+(0.08*p2i)+(0.16*p2f)