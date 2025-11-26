# variant 21, ex. 1
import math

n = int(input('Enter list length: '))

a = []
for i in range(n):
  x = int(input(f'Enter {i + 1} element of list: '))
  a.append(x)

print(sum(a))
print(math.prod(a))