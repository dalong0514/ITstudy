from random import choice

class RandomWalk():

	def __init__(self, num_points=5000):
		self.num_points = num_points

		# 所有的随机漫步都始于 (0,0)
		self.x_value = [0]
		self.y_value = [0]
