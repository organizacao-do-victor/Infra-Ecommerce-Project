const express = require('express')
const bodyParser = require('body-parser')
const dotenv = require('dotenv')

const { connectToPostgres, getProducts } = require('./postgres')
const { generateAccessToken } = require('./jwt')
const { checkExist, saveUser } = require('./mongo')

// -- dotenv
dotenv.config()

console.debug("Hello World!")

async function startServer() {
  console.log("Server starting...")

  // -- Express
  const app = express()
  app.use(bodyParser.urlencoded({ extended: true }))
  app.use(express.static('public'))

  // -- Root get
  app.get('/', (req, res) => {
    console.log(req.headers)
    res.send("Hello world!")
  })

  // -- Mongo
  console.log("Connecting to MongoDB user database...")
  await connectToMongo()
  console.log("Connected to MongoDB user database.")

  // -- Postgres
  console.log("Connecting to PostgreSQL product database...")
  await connectToPostgres()
  console.log("Connected to PostgreSQL product database.")

  // -- User login
  app.post('/login', async (req, res) => {
    const { username, password } = req.body
    const exists = await checkExist(username)

    if (exists === null) {
      res.statusCode = 406
      res.send('User does not exist')
    } else {
      if (exists.password === password) {
        const token = generateAccessToken({ username: username })
        res.statusCode = 200
        res.json(token)
      } else {
        res.status = 406
        res.send('Incorrect password')
      }
    }
  })

  // -- User signup
  app.post('/signup', async (req, res) => {
    const { username, password } = req.body
    const exists = await checkExist(username)

    if (exists === null) {
      await saveUser(username, password)
      const token = generateAccessToken({ username: username })
      res.statusCode = 200
      res.json(token)
    } else {
      res.statusCode = 406
      res.send('User already exists')
    }
  })

  // -- Get all products
  app.get('/products', async (req, res) => {
    const products = await getProducts()
    res.statusCode = 200
    res.json(products)
  })

  console.log("Server up.")
  app.listen(5000)
}

startServer()

