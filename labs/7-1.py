# variant 21
storage = {
  'Абрикос': {
    'weight': 30,
    'price': 120,
  },
  'Авокадо': {
    'weight': 19,
    'price': 90,
  },
  'Алыча': {
    'weight': 32,
    'price': 67,
  },
  'Апельсин': {
    'weight': 67,
    'price': 129,
  },
  'Арбуз': {
    'weight': 129,
    'price': 19,
  },
  'Гранат': {
    'weight': 36,
    'price': 56,
  },
  'Грейпфрут': {
    'weight': 23,
    'price': 78,
  },
  'Груша': {
    'weight': 57,
    'price': 20,
  },
  'Дыня': {
    'weight': 48,
    'price': 45,
  },
  'Инжир': {
    'weight': 12,
    'price': 54,
  },
  'Кешью': {
    'weight': 31,
    'price': 73,
  },
}

fruits = ['Абрикос', 'Авокадо', 'Алыча', 'Апельсин', 'Арбуз', 'Гранат', 'Грейпфрут', 'Груша', 'Дыня', 'Инжир', 'Кешью']

def input_fruit(name, weight):
  return (name, weight)

n = int(input('Enter number of requests: '))

request = []
cnt = 0
while cnt != n:
  name = input('Enter fruit: ')
  if name not in fruits:
    print('Error: No such fruit')
    continue

  weight = int(input(f'Enter quantity of {name}: '))

  if storage[name]['weight'] >= weight and weight <= 30:
    res = input_fruit(name, weight)
    new_request = {'name': res[0], 'weight': res[1]}
    request.append(new_request)

    storage[name]['weight'] = storage[name]['weight'] - weight

    cnt += 1
  elif storage[name]['weight'] >= weight and weight > 30:
    rest = weight - 30
    
    res = input_fruit(name, abs(weight - rest))
    new_request = {'name': res[0], 'weight': res[1]}
    request.append(new_request)
    
    res = input_fruit(name, rest)
    new_request = {'name': res[0], 'weight': res[1]}
    request.append(new_request)

    storage[name]['weight'] = storage[name]['weight'] - weight
  
    cnt += 1
  else:
    print(f'Error: Impossible to place order, not enough kg of {name} in storage')

print(request)