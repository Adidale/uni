# exercise 5
import math

# collecting data
a = int(input('Enter a: '))
b = int(input('Enter b: '))
c = int(input('Enter c: '))
d = int(input('Enter d: '))

# finding the smallest number
if a<b:
  if a<c:
    if a<d:
      minN = a

if b<a:
  if b<c:
    if b<d:
      minN = b

if c<a:
  if c<b:
    if c<d:
      minN = c

if d<a:
  if d<b:
    if d<c:
      minN = d

# showing data
print(minN)
print(math.cos(minN))