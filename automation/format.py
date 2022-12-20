dic = {}

with open('output') as file:
	for line in file:
		line = line.split(' = ')
		dic[line[0]] = line[1].replace('"','').strip()

with open('ansible/hosts','w+') as file:
	file.write('[vm]\n')
	file.write('{} ansible_user=ubuntu'.format(dic['Ansible-Public-IP']))

with open('ansible/remote-files/hosts', 'w+') as file:
	file.write('[front]\n{} ansible_user=ubuntu\n'.format(dic['Front-App-Public-IP']))
	file.write('[grafana]\n{} ansible_user=ubuntu\n'.format(dic['Grafana-Public-IP']))
	file.write('[db]\n{} ansible_user=ubuntu\n'.format(dic['Databases-Public-IP']))

with open('ansible/remote-files/s3', 'w+') as file:
	file.write(dic['Bucket-name'])

with open('ansible/remote-files/dotenv', 'w+') as file:
	file.write('bucketname={}'.format(dic['Bucket-name']))