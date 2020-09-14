const express = require("express");
const app = express();

const bodyParser = require('body-parser');

const passport = require('passport');
app.use(passport.initialize());
app.use(passport.session());


app.get('/',(req,res) => {
	res.send('');
});

app.listen(3000, () =>{
	console.log('listening');
});
