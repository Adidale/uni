import math

a = float(input('enter a: '))
b = float(input('enter b: '))
c = float(input('enter c: '))

t = ((a**-1 + b**-2 + c**-3) / (math.pi * abs(a * b) - c)) + ((math.e**c + math.cos(b)) / (math.cos(c)))
print(t)