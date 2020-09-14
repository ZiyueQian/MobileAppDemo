//user model
const mongoose = require('mongoose');
const UserSchema = mongoose.Schema({
  	firstname: {
    	type: String,
    	required: true
  	},
  	lastname: {
    	type: String,
	    required: true
	},
	phone_number: {
	    type: String,
	    required: true
	},
	password: {
		type: String,
	    required: true
	}
	// roles: [
 //      {
 //        type: mongoose.Schema.Types.ObjectId,
 //        ref: "Role"
 //      }
 //    ]
});



const myUser = mongoose.model('User', UserSchema);
module.exports = myUser;