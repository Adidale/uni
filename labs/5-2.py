# variant 21, ex. 2
import itertools

def triangle(a,b,c):
  p = itertools.permutations([a,b,c])
  if all(combo[0] + combo[1] > combo[2] for combo in p):
    return True
  return False

while True:
  a = float(input('Enter side a (a > 0): '))
  if a > 0:
    print('Data OK! \n')
    break
  print('Invalid data. Try again \n')

while True:
  b = float(input('Enter side b (b > 0): '))
  if b > 0:
    print('Data OK! \n')
    break
  print('Invalid data. Try again \n')

while True:
  rest1 = a - b
  rest2 = b - a
  e = float(input(f'Enter diagonal e ({rest1 if rest1 > rest2 else rest2} < e < {a + b}): '))
  if e > 0 and triangle(a,b,e):
    print('Data OK! \n')
    break
  print('Invalid data. Try again \n')

while True:
  c = float(input('Enter side c (c > 0): '))
  if c > 0:
    print('Data OK! \n')
    break
  print('Invalid data. Try again \n')

while True:
  rest1 = b - c
  rest2 = c - b
  f = float(input(f'Enter diagonal f ({rest1 if rest1 > rest2 else rest2} < f < {b + c}): '))
  if f > 0 and triangle(b,c,f):
    print('Data OK! \n')
    break
  print('Invalid data. Try again \n')

while True:
  rest1 = c - e
  rest2 = e - c

  rest3 = f - a
  rest4 = a - f
  
  triang_1_inf_rest = rest1 if rest1 > rest2 else rest2
  triang_2_inf_rest = rest3 if rest3 > rest4 else rest4

  d = float(input(f'Enter side d ({triang_1_inf_rest if triang_1_inf_rest > triang_2_inf_rest else triang_2_inf_rest} < d < {c + e if c + e < f + a else f + a}): '))

  if d > 0 and triangle(c,d,e) and triangle(a,d,f):
    print('Data OK! \n')
    break
  print('Invalid data. Try again \n')

tmp = 4 * e**2 * f**2 - (b**2 + d**2 - a**2 - c**2)**2

if triangle(a,b,e):
  print('Triangle ABE OK!')
if triangle(b,c,f):
  print('Triangle BCF OK!')
if triangle(c,d,e):
  print('Triangle CDE OK!')
if triangle(a,d,f):
  print('Triangle ADF OK! \n')

if triangle(a,b,e) and triangle(b,c,f) and triangle(c,d,e) and triangle(a,d,f) and tmp > 0:
  print('Quadrilateral possible!')
  s = 1/4 * tmp**0.5
  print(f'Area: {s}')