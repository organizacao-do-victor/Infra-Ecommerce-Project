import string
import secrets
NUMC = 32
def generateRandom():
	c = string.ascii_letters+string.digits
	return ''.join(secrets.choice(c) for i in range(NUMC))

dic = {}
dic['pgreUsr']='postgres'
dic['pgrePass']=generateRandom()
dic['pgrePort']='5432'
dic['pgreDB']='Prod'
dic['pgreTable']='product'
dic['mongoUser']=generateRandom()
dic['mongoPass']=generateRandom()
dic['mongoDB']='backend-db'

with open('output') as file:
	for line in file:
		line = line.split(' = ')
		dic[line[0]] = line[1].replace('"','').strip()
dic['ECR-URL']='{}.dkr.ecr.{}.amazonaws.com'.format(dic['AWS-ID'], dic['AWS-Region'])


dic['branch'] = 'HEAD'
try:
	with open('../.git/HEAD') as file:
		dic['branch'] = file.readline().strip().split('ref: refs/heads/')[1]
except:
	pass

with open('ansible/hosts','w+') as file:
	file.write('[vm]\n')
	file.write('{} ansible_user=ubuntu'.format(dic['Ansible-Public-IP']))

with open('ansible/ansible-vars.yaml','w+') as file:
	file.write('branch: {}\n'.format(dic['branch']))

with open('ansible/remote-files/repo', 'w+') as file:
	file.write('{}'.format(dic['ECR-URL']))

with open('ansible/remote-files/hosts', 'w+') as file:
	file.write('[front-back]\n{} ansible_user=ubuntu\n'.format(dic['Front-App-Public-IP']))
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
	file.write('PGUSER={}\n'.format(dic['pgreUsr']))
	file.write('PGDATABASE={}\n'.format(dic['pgreDB']))
	file.write('PGTABLE={}\n'.format(dic['pgreTable']))
	file.write('PGPASSWORD={}\n'.format(dic['pgrePass']))
	file.write('PGPORT={}\n'.format(dic['pgrePort']))

with open('ansible/remote-files/ansible-vars.yaml', 'w+') as file:
	file.write('pgreHost: {}\n'.format(dic['Databases-Public-IP']))
	file.write('pgreDB: {}\n'.format(dic['pgreDB']))
	file.write('pgreTable: {}\n'.format(dic['pgreTable']))
	file.write('pgreUser: {}\n'.format(dic['pgreUsr']))
	file.write('pgrePass: {}\n'.format(dic['pgrePass']))

with open('ansible/remote-files/dbenv', 'w+') as file:
	file.write('pgreUser={}\n'.format(dic['pgreUsr']))
	file.write('pgrePass={}\n'.format(dic['pgrePass']))
	file.write('pgreDB={}\n'.format(dic['pgreDB']))
	file.write('mongoUser={}\n'.format(dic['mongoUser']))
	file.write('mongoPass={}\n'.format(dic['mongoPass']))
	file.write('mongoDB={}\n'.format(dic['mongoDB']))
	file.write('awsRepo={}'.format(dic['ECR-URL']))
