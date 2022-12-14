dic = {}

with open('output') as file:
	for line in file:
		line = line.split(' = ')
		dic[line[0]] = line[1].strip()

with open('hosts','w+') as file:
	file.write('[vm]\n {} ansible_user=ubuntu'.format(dic['ec2_IP']))