dic = {}

with open('output') as file:
	for line in file:
		line = line.split(' = ')
		dic[line[0]] = line[1].replace('"','').strip()

with open('../banco/dbcred') as file:
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
	file.write('MONGOUSER={}\n'.format(dic['mongoUser']))
	file.write('MONGOPASSWORD={}\n'.format(dic['mongoPass']))
	file.write('MONGOHOST={}\n'.format(dic['Databases-Public-IP']))
	file.write('MONGODATABASE={}\n'.format(dic['mongoDB']))
	file.write('BUCKETNAME={}\n'.format(dic['Bucket-name']))
	file.write('PGHOST={}\n'.format(dic['Databases-Public-IP']))
	file.write('PGUSER={}\n'.format('postgres'))
	file.write('PGDATABASE={}\n'.format(dic['pgreDB']))
	file.write('PGPASSWORD={}\n'.format(dic['pgrePass']))
	file.write('PGPORT={}\n'.format('5432'))