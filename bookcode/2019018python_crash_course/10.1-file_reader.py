filename = "/Users/Daglas/zancun/2019001.txt"

with open(filename) as f:
	#contents = file_object.read()
	lines = f.readlines()

for line in lines[:10]:
	print(line)