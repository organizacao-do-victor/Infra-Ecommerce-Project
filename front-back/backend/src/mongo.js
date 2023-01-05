const dotenv = require('dotenv')
const mongoose = require('mongoose')

dotenv.config()

const user = process.env.MONGOUSER
const password = process.env.MONGOPASSWORD
const host = process.env.MONGOHOST
const database = process.env.MONGODATABASE

const mongodbUrl = `mongodb+srv://${user}:${password}@${host}/${database}`

const userSchema = new mongoose.Schema({
  username: String,
  password: String,
  roles: [String]
})

async function connectToMongo() {
  mongoose.set('strictQuery', false)
  mongoose.connect(mongodbUrl)
}

async function checkExist(username) {
  const User = mongoose.model("User", userSchema)
  const exists = await User.findOne({ username: username })
  return exists
}

async function saveUser(username, password) {
  const User = mongoose.model("User", userSchema)
  const user = new User({ username, password })
  const ret = await user.save()
  return ret
}

module.exports = {
  connectToMongo,
  checkExist,
  saveUser
}