import psycopg2

values = {}
files = ['ip','senha']
for fn in files:
	with open(fn) as f:
		for line in f:
			k, v = line.replace('"','').split(' = ',2)
			values[k] = v

pgPass = values['pgPass']
pgHost = values['pgHost']

#conecta com o banco
try:
    con = psycopg2.connect(database="postgres", user="postgres", password=pgPass, host=pgHost, port=5432,)
except Exception as e:
    print(e)
    print('CONNECTION ERROR')
    exit(1)
cur = con.cursor()

#cur.execute('drop table produtos')
cur.execute('create table produtos(ID SERIAL PRIMARY KEY NOT NULL, NOME TEXT NOT NULL, DESCR TEXT NOT NULL, QTD SMALLINT NOT NULL, PRECO DECIMAL NOT NULL)')
#cur.execute("insert into produtos(nome,descr,qtd,preco) values ('testp','desc ...', 3, 10.06)")
con.commit()

cur.close()
con.close()

