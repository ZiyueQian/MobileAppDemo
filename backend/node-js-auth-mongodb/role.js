//role model
const mongoose = require('mongoose');
const RoleSchema = mongoose.Schema({
  	title: {
    	type: String,
    	required: true
  	}
});

const myRole = mongoose.model('Role', RoleSchema);
module.exports = myRole;