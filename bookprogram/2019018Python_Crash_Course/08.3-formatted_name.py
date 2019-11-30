def get_formatted_name(first_name, last_name, middle_name=" "):
	full_name = first_name+" "+middle_name+" "+last_name
	return full_name.title()
musician = get_formatted_name('feng', ' ', 'long')
print(musician)