# variant 21, ex. 1
while True:
  a = int(input('Enter a number between 0 and 50 (0 ≤ a ≤ 50): '))
  if 0 <= a <= 50:
    print('Data OK!')
    break
  print('Invalid number. Try again')

s = 0
for i in range(a, 51):
  s += i**2

print(f'Square summ: {s}')