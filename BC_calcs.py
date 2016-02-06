import numpy as np

# V = a*b*c, x = c/a, y = c/b
# cbrt(V*x*y) = c 

V = 47.773 # A^3
x = 0.6328
y = 0.6421

c = np.power(V*x*y, 1./3.)
a = c/x
b = c/y


print a, b, c
