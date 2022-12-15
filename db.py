#####################
#  Postgres
###################
import psycopg2
pgPass = "pass"
pgHost = '0.0.0.0'


#conecta com o banco
try:
    con = psycopg2.connect(database="postgres", user="postgres", password=pgPass, host=pgHost, port=5432,)
except Exception as e:
    print(e)
    print('ERRO')
    exit(1)
cur = con.cursor()

#cur.execute('select * from vids')
#for name, path in cur.fetchall():
cur.close()
con.close()



#################
# Mongo
##################
#https://pymongo.readthedocs.io/en/stable/api/pymongo/index.html
import pymongo

mngUser = "root"
mngPass = 'pass'
mngHost = '0.0.0.0'

conn_str = "mongodb://{}:{}@{}:27017/?authSource=admin".format(mngUser, mngPass, mngHost)
client = pymongo.MongoClient(conn_str, serverSelectionTimeoutMS=1000)
try:
#    print(client.server_info())
	for d in client.test.test.find():
		print(d)
except Exception:
    print("Unable to connect to the server.")