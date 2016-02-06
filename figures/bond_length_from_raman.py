import numpy as np

def O_O_length(nu):
    return -0.1321*np.log((3592. - nu)/304.e9)
def H_O_length(nu):
    return -0.2146*np.log((3632. - nu)/1.79e6)

print O_O_length(2850.)
print O_O_length(2960.)
print H_O_length(2850.)
print H_O_length(2960.)
