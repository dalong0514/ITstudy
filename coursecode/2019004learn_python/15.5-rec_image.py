import requests

content = requests.get('https://pixabay.com/zh/images/search/封面/').text
print(content)