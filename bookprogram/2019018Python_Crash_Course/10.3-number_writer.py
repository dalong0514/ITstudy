import json

number = list(range(3,10))

filename = 'number.json'
with open(filename, 'w') as f_obj:
	json.dump(number,f_obj)