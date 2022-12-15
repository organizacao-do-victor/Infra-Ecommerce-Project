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

cur.execute('select * from produtos')
for _, name, desc, qtd, preco in cur.fetchall():
	print('{} | {} | {} | {}'.format(name,desc,qtd,preco))
cur.close()
con.close()