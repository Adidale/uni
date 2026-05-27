# variant 21, ex. 1
def checkNum(n):
  if all(d in (a,b,c) for d in n):
    return 1
  return 0

while True:
  n = int(input('Enter a number between 210 and 231 (210 < n < 231): '))
  if 210 < n < 231:
    print('Data OK!')
    break
  print('Invalid data. Try again')

e = [str(x) for x in range(100, n)]

while True:
  a = input('Enter a digit (0 - 9):')
  if 0 <= int(a) <= 9:
    print('Data OK!')
    break
  print('Invalid data. Try again')

while True:
  b = input('Enter a digit (0 - 9):')
  if 0 <= int(b) <= 9:
    print('Data OK!')
    break
  print('Invalid data. Try again')

while True:
  c = input('Enter a digit (0 - 9):')
  if 0 <= int(c) <= 9:
    print('Data OK!')
    break
  print('Invalid data. Try again')

k = 0
for i in e:
  if checkNum(i) == 1:
    k += 1
    print(i)

print(k)