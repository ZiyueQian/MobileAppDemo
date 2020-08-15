require('dotenv').config();
require('./process.env')

//express
const express = require("express");
const app = express();

//bcryptjs
const bcrypt = require('bcryptjs');

//bodyParser
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

//JWT
const jwt = require("jsonwebtoken");

app.use(express.json());

//mongoose
const mongoose = require('mongoose');
const myRole = require('./role.js');
const myUser = require('./user.js');
const url = 'mongodb://127.0.0.1:27017/inventoryTrack';
mongoose.connect(url, { useNewUrlParser: true });

const db = mongoose.connection;
// db.once('open', _ => {
//   console.log('Database connected:', url)
// })

// db.on('error', err => {
//   console.error('connection error:', err)
// })

const user_collection = db.collection('user');


app.post('/api', (req,res) =>{
	const userPhoneNumber = req.body.phone_number
	const user = {phone_number: userPhoneNumber}

	const accessToken = generateAccessToken(user)
	const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET)
	res.status(200).json({accessToken: accessToken, refreshToken: refreshToken});

	
})

function generateAccessToken(user){
	return jwt.sign(user,process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15s'});
}



app.listen(4000)