aliens = []

# 创建 30 个绿色的外星人
for alien_number in range(30):
	new_alien = {'color':'green', 'points':'5', 'speed':'slow'}
	aliens.append(new_alien)

# 改变前 3 个外星人属性
for alien in aliens[:3]:
	if alien['color'] == 'green':
		alien['color'] = 'yellow'
		alien['speed'] = 'medium'
		alien['points'] = 10

# 显示前 5 个外星人
for alien in aliens[:5]:
	print(alien)
print("...")

# 显示创建了多少个外星人
print("Total number of aliens: "+str(len(aliens)))