#for value in range(2,10):
	#print(value)
#numbers = list(range(1,11,4))
#print(numbers)

squares = []
for value in range(1,11):
	squares.append(value**3)
#print(sum(squares))

players = ['dalong', 'xiaomomo','xiaoming', 'xiaobai', 'xiaohei']
for player in players[:]:
	print(player.title())