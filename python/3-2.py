# exercise 9

# collecting data
n = int(input('Enter month (1-12): '))

# months array
months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

# validating data
if n < 1 or n > 12:
  print('Invalid month')
else:
  # showing month
  print(months[n - 1])