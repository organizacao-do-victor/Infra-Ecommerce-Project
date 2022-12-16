const express = require('express')
const mongoose = require('mongoose')


function mongo() {
  const mongodbUrl = 'mongodb://root:pass@3.87.237.32:27017/ecommerce?authMechanism=DEFAULT&authSource=admin&tls=false'
  mongoose.set('strictQuery', false)
  mongoose.connect(mongodbUrl)
}
mongo()

const userSchema = {
  user: String,
  pwd: String
}

const User = mongoose.model("User", userSchema)

User.find(function(err, users) {
  if (!err) { 
    console.log(users)
  } else {
    console.log(err)
  }
})

const app = express()
app.use(express.static('public'))
app.get('/', function(req, res) {
   res.send("Hello world!")
})

app.listen(9999)