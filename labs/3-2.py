# exercise 9

# collecting data
n = int(input('Enter month (1-12): '))

# months array
months = ['January', 'February', 'March', 'April', 'May', 'June', 'Jule', 'August', 'September', 'October', 'Novermber', 'December']

# validating data
if n < 1 or n > 12:
  print('Invalid month')
else:
  # showing month
  print(months[n - 1])