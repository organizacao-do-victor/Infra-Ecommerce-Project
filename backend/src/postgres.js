const dotenv = require('dotenv')
const { Client } = require('pg')

dotenv.config()

const client = new Client()

async function connectToPostgres() {
  await client.connect()
}

async function getProducts() {
  const res = await client.query('SELECT * FROM product')
  return res.rows
}

module.exports = {
  connectToPostgres,
  getProducts
}