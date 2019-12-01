from collections import OrderedDict

favorite_languages = OrderedDict()

favorite_languages['dalong'] = 'python'
favorite_languages['xiaomo'] = 'c'
favorite_languages['xiaobai'] = 'ruby'
favorite_languages['xiaoming'] = 'java'

for name, language in favorite_languages.items():
	print(name.title()+"'s favorite language is "+language.title()+".")

#favorite_languages = {
#	'dalong':'python',
#	'xiaomo':'c',
#	'xiaobai':'ruby',
#	'xiaoming':'java',
#	}

#for name, language in favorite_languages.items():
#	print(name.title()+"'s favorite language is "+language.title()+".")

#for name in sorted(favorite_languages.keys()):
#	print(name.title()+", thank you for taking the poll.")