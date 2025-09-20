# Variant 21
import math

# colleting data
# a = -3.13
# b = 2.2
# c = 0.5
a = float(input('enter a: '))
b = float(input('enter b: '))
c = float(input('enter c: '))

# calculating t and printing it
t = ((a**-1 + b**-2 + c**-3) / (math.pi * abs(a * b) - c)) + ((math.e**c + math.cos(b)) / (math.cos(c)))
print("{:.2f}".format(t))