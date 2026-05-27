# variant 21, ex. 2
n = int(input('Enter list length: '))

a = []
for i in range(n):
  x = int(input(f'Enter {i + 1} element of list: '))
  a.append(x)

print('Resulting list:')
print(a)

mean = sum(a)/len(a)
print('Mean of all elements in list:', mean)

for i in range(len(a)):
  if a[i] == 0:
    a[i] = mean

print('Eliminating 0...')
print(a)