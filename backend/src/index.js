const express = require('express')
const bodyParser = require('body-parser')
const dotenv = require('dotenv')

const { connectToPostgres, getProducts } = require('./postgres')
const { generateAccessToken } = require('./jwt')
const { connectToMongo, checkExist, saveUser } = require('./mongo')

// -- dotenv
dotenv.config()

async function startServer() {
  // -- Mongo
  await connectToMongo()

  // -- Postgres
  await connectToPostgres()

  // -- Express
  const app = express()
  app.use(bodyParser.urlencoded({ extended: true }))
  app.use(express.static('public'))

  // -- Root get
  app.get('/', (req, res) => {
    console.log(req.headers)
    res.send("Hello world!")
  })

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


  app.listen(9999)
}

startServer()

