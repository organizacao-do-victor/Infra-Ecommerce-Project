import string
import secrets
import sys 

#####################
#	RANDOM STRINGS
####################
NUMC = 32
def generateRandom():
	c = string.ascii_letters+string.digits
	return ''.join(secrets.choice(c) for i in range(NUMC))

######################
#	HARDCODED VALUES
#####################
FRONTPORT = '3000'
PROMETHEUSPORT = '9100'
dic = {}
dic['pgreUsr']='postgres'
dic['pgrePort']='5432'
dic['pgreDB']='products'
dic['pgreTable']='product'
dic['mongoDB']='backend-db'

#don't generate new on update
generate = True
if(len(sys.argv) > 1):
	if(sys.argv[1] == '-ng'):
		print('generation disabled')
		generate = False

if(generate):
	dic['pgrePass']=generateRandom()
	dic['mongoUser']=generateRandom()
	dic['mongoPass']=generateRandom()
else:
	with open('ansible/remote-files/dbenv') as file:
		for line in file:
			k,v = line.strip().split('=',2)
			if k in ('pgrePass', 'mongoUser', 'mongoPass'):
				dic[k] = v

########################
#	READ FROM TERRAFORM
#######################
with open('output') as file:
	for line in file:
		line = line.split(' = ')
		dic[line[0]] = line[1].replace('"','').strip()
dic['ECR-URL']='{}.dkr.ecr.{}.amazonaws.com'.format(dic['AWS-ID'], dic['AWS-Region'])

######################
#	GET GIT BRANCH
#####################
dic['branch'] = 'HEAD'
try:
	with open('../.git/HEAD') as file:
		dic['branch'] = file.readline().strip().split('ref: refs/heads/')[1]
except:
	pass


######################
#	ANSIBLELH HOSTS
#####################
with open('ansible/hosts','w+') as file:
	file.write('[vm]\n')
	file.write('{} ansible_user=ubuntu'.format(dic['Ansible-Public-IP']))
######################
#	ANSIBLELH VARS
#####################
with open('ansible/ansible-vars.yaml','w+') as file:
	file.write('branch: {}\n'.format(dic['branch']))

######################
#	AWS ECR REPO
#####################
with open('ansible/remote-files/repo', 'w+') as file:
	file.write('{}'.format(dic['ECR-URL']))

######################
#	ANSIBLEVM HOSTS
#####################
with open('ansible/remote-files/hosts', 'w+') as file:
	file.write('[nginx]\n{} ansible_user=ubuntu\n'.format(dic['Nginx-Public-IP']))
	file.write('[front-back]\n{} ansible_user=ubuntu\n'.format(dic['Front-App-Public-IP']))
	file.write('[app-hs]\n{} ansible_user=ubuntu\n'.format(dic['Front-App-HS-Public-IP']))
	file.write('[grafana]\n{} ansible_user=ubuntu\n'.format(dic['Grafana-Public-IP']))
	file.write('[db]\n{} ansible_user=ubuntu\n'.format(dic['Databases-Public-IP']))

######################
#	ANSIBLEVM VARS
#####################
with open('ansible/remote-files/ansible-vars.yaml', 'w+') as file:
	file.write('pgreHost: {}\n'.format(dic['Databases-Public-IP']))
	file.write('pgreUser: {}\n'.format(dic['pgreUsr']))
	file.write('pgrDB: {}\n'.format(dic['pgreDB']))
	file.write('pgrTable: {}\n'.format(dic['pgreTable']))
	file.write('pgrePass: {}\n'.format(dic['pgrePass']))
	file.write('mongoHost: {}\n'.format(dic['Databases-Public-IP']))
	file.write('mongoUser: {}\n'.format(dic['mongoUser']))
	file.write('mongoDB: {}\n'.format(dic['mongoDB']))
	file.write('mongoPass: {}\n'.format(dic['mongoPass']))

######################
#	S3 BUCKET NAME
#####################
with open('ansible/remote-files/s3', 'w+') as file:
	file.write(dic['Bucket-name'])

######################
#	NODE .ENV
#####################
with open('ansible/remote-files/dotenv', 'w+') as file:
	file.write('MONGOUSER={}\n'.format(dic['mongoUser']))
	file.write('MONGOPASSWORD={}\n'.format(dic['mongoPass']))
	file.write('MONGOHOST={}\n'.format(dic['Databases-Public-IP']))
	file.write('MONGODATABASE={}\n'.format(dic['mongoDB']))
	file.write('BUCKETNAME={}\n'.format(dic['Bucket-name']))
	file.write('PGHOST={}\n'.format(dic['Databases-Public-IP']))
	file.write('PGUSER={}\n'.format(dic['pgreUsr']))
	file.write('PGDATABASE={}\n'.format(dic['pgreDB']))
	file.write('PGPASSWORD={}\n'.format(dic['pgrePass']))
	file.write('PGPORT={}\n'.format(dic['pgrePort']))
######################
#	FRONT REPO ENV
#####################
with open('ansible/remote-files/frontenv', 'w+') as file:
	file.write('awsRepo={}'.format(dic['ECR-URL']))
######################
#	BACK REPO JS
#####################
with open('ansible/remote-files/frontenv', 'w+') as file:
	file.write('awsRepo={}'.format(dic['ECR-URL']))
with open('ansible/remote-files/back.js', 'w+') as file:
	file.write('const API = "{}"\n'.format(dic['Front-App-Public-IP']))
	file.write('module.exports = {\n\tAPI\n}')
with open('ansible/remote-files/backHS.js', 'w+') as file:
	file.write('const API = "{}"\n'.format(dic['Front-App-HS-Public-IP']))
	file.write('module.exports = {\n\tAPI\n}')

######################
#	DB .ENV
#####################
with open('ansible/remote-files/dbenv', 'w+') as file:
	file.write('pgreUser={}\n'.format(dic['pgreUsr']))
	file.write('pgrePass={}\n'.format(dic['pgrePass']))
	file.write('pgreDB={}\n'.format(dic['pgreDB']))
	file.write('mongoUser={}\n'.format(dic['mongoUser']))
	file.write('mongoPass={}\n'.format(dic['mongoPass']))
	file.write('mongoDB={}\n'.format(dic['mongoDB']))
	file.write('awsRepo={}'.format(dic['ECR-URL']))

#######################
#	AWS REGION CONFIG
######################
with open('ansible/remote-files/awsconfig', 'w+') as file:
	file.write('[default]\nregion = {}'.format(dic['AWS-Region']))

#######################
#	PROMETHEUS.YML
######################
with open('prometheus.yml.template') as template:
	with open('ansible/remote-files/prometheus.yml', 'w+') as file:
		for line in template:
			if('{{ANSIBLE IP}}' in line):
				ip = "'" + dic['Ansible-Public-IP'] + ":" + PROMETHEUSPORT + "'"
				file.write(line.replace('{{ANSIBLE IP}}', ip))
			elif('{{FRONT-BACK IP}}' in line):
				ip = "'" + dic['Front-App-Public-IP'] + ":" + PROMETHEUSPORT + "'"
				file.write(line.replace('{{FRONT-BACK IP}}', ip))
			elif('{{APP-HS IP}}' in line):
				ip = "'" + dic['Front-App-HS-Public-IP'] + ":" + PROMETHEUSPORT + "'"
				file.write(line.replace('{{APP-HS IP}}', ip))
			elif('{{DB IP}}' in line):
				ip = "'" + dic['Databases-Public-IP'] + ":" + PROMETHEUSPORT + "'"
				file.write(line.replace('{{DB IP}}', ip))
			elif('{{NGINX IP}}' in line):
				ip = "'" + dic['Nginx-Public-IP'] + ":" + PROMETHEUSPORT + "'"
				file.write(line.replace('{{NGINX IP}}', ip))
			else:
				file.write(line)

#######################
#	NGINX.CONF
######################
with open('nginx.conf.template') as template:
	with open('ansible/remote-files/nginx.conf', 'w+') as file:
		for line in template:
			if('{{FRONT}}' in line):
				ip = dic['Front-App-Public-IP'] + ":" + FRONTPORT
				file.write(line.replace('{{FRONT}}', ip))
			elif('{{HS}}' in line):
				ip = dic['Front-App-HS-Public-IP'] + ":" + FRONTPORT
				file.write(line.replace('{{HS}}', ip))
			else:
				file.write(line)



