import numpy as np

numbers = np.array([0.1, 0.2, 0.35, 0.2, 0.4, 0.1])

def find_maxima(list_of_numbers):
    maxima = []
    for i, n in enumerate(numbers):
        if i>0 and n>numbers[i-1] and n>numbers[i+1] and i<len(numbers):
            maxima.append([i, n])
    return maxima

filename = 'index_maxima.dat'
f = open(filename, 'w')
for idx, maximum in zip(*find_maxima(numbers)):
    f.write(str(idx)+' '+str(maximum)+'\n')

f.close()
print filename, '(over)written'
