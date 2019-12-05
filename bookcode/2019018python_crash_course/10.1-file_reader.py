filename = "2019001债务.md"

with open(filename) as file_object:
	#contents = file_object.read()
	lines = file_object.readlines()

for line in lines[:10]:
	print(line)