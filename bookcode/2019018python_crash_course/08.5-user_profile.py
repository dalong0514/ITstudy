def build_profile(frist, last, **user_info):
	profile = {}
	profile['frist_name'] = frist
	profile['last_name'] = last
	for key, value in user_info.items():
		profile[key] = value
	return profile

user_profile = build_profile('albert', 'einstein', location='princeton', field='physics')
print(user_profile)