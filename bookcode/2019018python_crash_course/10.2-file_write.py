readfile = "/Users/Daglas/Desktop/2019001.txt"
writefile = "/Users/Daglas/Desktop/2019002.txt"

with open(readfile) as file_object:
	lines = file_object.readlines()
	#contents = file_object.read()

# lines.remove('\n')

for line in lines[0:10]:
    with open(writefile, 'w') as file_object:
    	file_object.write(line)