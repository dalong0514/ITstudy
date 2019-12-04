import pygal
from die import Die

# 创建一个 D6
die = Die()
results = []
for roll_num in range(1000):
    result = die.roll()
    results.append(result)

# 分析结果

frequences = []
for value in range(1, die.num_sides+1):
    frequence = results.count(value)
    frequences.append(frequence)

hist = pygal.Bar()

hist.title = "Results of rolling one D6 1000 times. "
hist.x_labels = ['1', '2', '3', '4', '5', '6']
hist.x_title = "Results"
hist.y_title = "Frequence of Results"

hist.add('D6', frequences)
hist.render_to_file('die_visual.svg')