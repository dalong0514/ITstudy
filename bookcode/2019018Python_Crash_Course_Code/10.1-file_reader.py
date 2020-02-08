filename = "/Users/Daglas/Desktop/2019001.txt"

with open(filename) as f:
	#contents = file_object.read()
	lines = f.readlines()

# lines.remove('\n')

for line in lines:
	print(line)