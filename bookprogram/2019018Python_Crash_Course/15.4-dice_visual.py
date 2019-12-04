import pygal
from die import Die

# 创建 2 个 D6
die_1 = Die()
die_2 = Die()

# 投掷骰子多次，并将结果存储到一个列表中
results = []
for roll_num in range(1000):
    result = die_1.roll() + die_2.roll()
    results.append(result)

# 分析结果

frequences = []
max_result = die_1.num_sides + die_2.num_sides
for value in range(2, max_result+1):
    frequence = results.count(value)
    frequences.append(frequence)

# 可视化结果
hist = pygal.Bar()

hist.title = "Results of rolling two D6 dice 1000 times. "
hist.x_labels = ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
hist.x_title = "Results"
hist.y_title = "Frequence of Results"

hist.add('D6 + D6', frequences)
hist.render_to_file('dice_visual.svg')