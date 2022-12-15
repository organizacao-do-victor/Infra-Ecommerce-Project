import psycopg2
class prodDB():
	def __init__(self, pgPass, pgHost):
		#conecta com o banco
		try:
			self.con = psycopg2.connect(database="postgres", user="postgres", password=pgPass, host=pgHost, port=5432,)
		except Exception as e:
			print(e)
			print('CONNECTION ERROR')
			exit(1)
		self.cur = self.con.cursor()

	def getProds(self):
		prods = []
		self.cur.execute('select * from produtos')
		for _, name, desc, qtd, preco in self.cur.fetchall():
			prods += [(name,desc,qtd,preco)]
		return prods;

	def getProd(self):
		prods = []
		self.cur.execute("select * from produtos where nome = '{}'".format(p))
		_, name, desc, qtd, preco in self.cur.fetchone()
		return (name, desc, qtd, preco)
	
	def close(self):
		self.cur.close()
		self.con.close()

if __name__ == '__main__':
	db = prodDB('pass','0.0.0.0')
	for name, desc, qtd, preco in db.getProds():
		print('{} | {} | {} | {}'.format(name,desc,qtd,preco))