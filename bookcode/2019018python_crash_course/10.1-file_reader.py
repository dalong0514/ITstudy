filename = "2019911.txt"

with open(filename) as f:
	#contents = file_object.read()
	lines = f.readlines()

for line in lines[:10]:
	print(line)