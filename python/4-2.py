# variant 21, ex. 2
while True:
  n = int(input('Enter a number greater than 1 (n > 1): '))
  if n > 1:
    print('Data OK!')
    break
  print('Invalid number. Try again')

k = 0
while 5**k <= n:
  k += 1

print(f'K = {k}')