readfile = "2019001债务.txt"
writefile = "2019001债务01.txt"

with open(readfile) as file_object:
	lines = file_object.readlines()
	#contents = file_object.read()

#p_string = ''
#for line in lines[0:20]:
#	p_string += line.strip()

with open(writefile, 'w') as file_object:
	file_object.write(contents)