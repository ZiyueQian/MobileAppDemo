//express
const express = require("express");
const app = express();

//bcryptjs
const bcrypt = require('bcryptjs');

//bodyParser
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

//mongoose
const mongoose = require('mongoose');
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

const UserSchema = mongoose.Schema({
  	firstname: {
    	type: String,
    	required: true
  	},
  	lastname: {
    	type: String,
	    required: true
	},
	email: {
	    type: String,
	    required: true
	},
	password: {
		type: String,
	    required: true
	},
	confirmPassword: {
		type: String,
	    required: true
	}
});



let myUser = mongoose.model('User', UserSchema);
module.exports = myUser;

UserSchema.pre('save', function(next) {
	var user = this;

  	if (!user.isModified('password')) 
  		return next();

  	bcrypt.hash(user.password, 10, function(err, hash){
    	if (err) {
      		return next(err);
    	}
    	user.password = hash;
    	next();
  	})
});

//sign up page
app.post('/signup', (req,res) => {
	var current_user = new myUser();

	
	//hash password with bcryptjs
	bcrypt.hash(req.body.password, 10, function(err, hash){
    	if (err) {
      		throw err;
    	}
    	const newUser = new myUser({
			firstname: req.body.firstname,
			lastname: req.body.lastname,
			email: req.body.email,
			password: hash
		});


		const newEmail = {email: newUser.email};
		user_collection.findOne(newEmail, (err, result) => {
			//save new user to database if email doesn't exist already
			if(result == null){
				user_collection.insertOne(newUser,(err, result) =>{
					res.status(200).send();
				});
			}else{
				res.status(400).json('user already exists');
			}
		});

	});
	

	
  
});

//log in page
app.post('/login', (req,res) => {
	const newLogin = {
		email: req.body.email,
		password: req.body.password
	}

	const loginEmail = {email: newLogin.email};
	const loginPassword = {password: newLogin.password};

	user_collection.findOne(loginEmail).then(user =>{
		//check if user exists already
		if (!user){
			return res.status(404).json('user does not exist.');
		}

		//compare password
		bcrypt.compare(req.body.password, user.password).then(isMatch => {

			if (!isMatch) {
		    	res.status(400).json("Password doesn't match");
	  		} else{
	  			const objToSend = {
	  				name: user.firstname
	  			}
	  			res.status(200).send(JSON.stringify(objToSend))
	  		}
		});

	})
	
});

//profile page -- not implemented yet
app.get('/profile/:id',(req,res) => {
	const { id } = req.params;
	let found = false;
	database.users.forEach(user =>{
		if(user.id === id){
			found = true;
			return res.json(user);
		}
	})

	if(!found){
		res.status(400).json('not found');
	}
})


app.get('/',(req,res) => {
	res.send('');
});

app.listen(3000, () =>{
	console.log('listening');
});
