require('dotenv').config();
let refreshTokens = [];

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


const user_collection = db.collection('user');

//const UserSchema = myUser.UserSchema;
// UserSchema.pre('save', function(next) {
// 	var user = this;

//   	if (!user.isModified('password')) 
//   		return next();

//   	bcrypt.hash(user.password, 10, function(err, hash){
//     	if (err) {
//       		return next(err);
//     	}
//     	user.password = hash;
//     	next();
//   	})
// });

//sign up page
app.post('/signup', (req,res) => {
	var current_user = new myUser();

	//check if passwords match
	if (req.body.password !== req.body.confirmPassword){
		res.status(401).json('password does not match');
	}
	else{
		//hash password with bcryptjs
		bcrypt.hash(req.body.password, 10, function(err, hash){
	    	if (err) {
	      		throw err;
	    	}
	    	const newUser = new myUser({
				firstname: req.body.firstname,
				lastname: req.body.lastname,
				phone_number: req.body.phone_number,
				password: hash
			});


			const newNumber = {phone_number: newUser.phone_number};
			user_collection.findOne(newNumber, (err, result) => {
				//save new user to database if phone number doesn't exist already
				if(result == null){
					user_collection.insertOne(newUser,(err, result) =>{
						res.status(200).send();
					});
				}else{
					res.status(400).json('user already exists');
				}
			});

		});
	}	
  
});

//log in page
app.post('/login', (req,res) => {
	const newLogin = {
		phone_number: req.body.phone_number,
		password: req.body.password
	}

	const loginNumber = {phone_number: newLogin.phone_number};
	const loginPassword = {password: newLogin.password};

	user_collection.findOne(loginNumber).then(user =>{
		//check if user exists already
		if (!user){
			return res.status(404).json('user does not exist.');
		}

		//compare password
		bcrypt.compare(req.body.password, user.password).then(isMatch => {

			if (!isMatch) {
		    	res.status(400).json("Password doesn't match");
	  		} else{

	  			const accessToken = jwt.sign(loginNumber,process.env.ACCESS_TOKEN_SECRET, { expiresIn: '90d'});
				const refreshToken = jwt.sign(loginNumber, process.env.REFRESH_TOKEN_SECRET);
				refreshTokens.push(refreshToken)
	  			res.status(200).send({
			        id: user._id,
			        firstname: user.firstname,
			        lastname: user.lastname,
			        phone_number: user.phone_number,
			        accessToken: accessToken,
			        refreshToken: refreshToken
      			});

      			//res.redirect('/userProfile');
	  		}
		});

	})
	
});

app.post('/resetPassword', (req,res) => {
	const resetInfo= {
		phone_number: req.body.phone_number,
		newPassword: req.body.password,
		newConfirmPassword: req.body.confirmPassword
	};

	const phoneNumber = {phone_number: resetInfo.phone_number};
	const newPassword = {password: resetInfo.newPassword};

	user_collection.findOne(phoneNumber).then(user =>{
		//check if user exists already
		if (!user){
			return res.status(404).json('user does not exist.');
		}

		//check if password match
		else if (req.body.password !== req.body.confirmPassword){
			res.status(401).json('password does not match');
		}

		//reset password
		else{
			//hash password with bcryptjs
			bcrypt.hash(req.body.password, 10, function(err, hash){
		    	if (err) {
		      		throw err;
		    	}
		    	else{
		    		var newPwrd = {$set: {password: hash} };
		    		user_collection.updateOne(user, newPwrd, function(err, result){
		    			if(err) {
		      				throw err;
		    			}
		    			else{
		    				res.json("updated");
		    				
		    			}
		    			
		    		})
		    	}
		    	

			});

		}

	})


});

function generateAccessToken(number){
	return jwt.sign(number,process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15s'});
}


app.get('/api', (req,res) =>{
	const authHeader = req.headers.authorization;
 	const token = authHeader && authHeader.split(' ')[1];
 	// for testing refreshToken log out delete
 	// if (!refreshTokens.includes(token))
 	// 	return res.json("no longer available")

	jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, function(err, newLogin){
        if(err){
            res.status(400).json("forbidden");
        } else {
        	req.user = newLogin;
        	
            res.json('logged in');
        }
    });

	
})


//profile page -- not implemented yet
app.get('/userProfile',(req,res) => {
	res.json('logged in');
})

//test delete refreshToken
app.delete('/logout', (req, res) => {
	refreshTokens = refreshTokens.filter(token => token != req.body.token);
	res.sendStatus(204)
})

app.get('/',(req,res) => {
	res.send('');
});

app.listen(3000, () =>{
	console.log('Listening');
});
