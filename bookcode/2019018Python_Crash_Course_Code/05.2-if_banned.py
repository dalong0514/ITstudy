banned_users = ['dalong', 'xiaomo', 'xiaobai', 'xiaohei']

user = 'dalong'
if user not in banned_users:
	print(user.title())
else:
	print(user.upper())