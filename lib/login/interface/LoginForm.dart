import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/home_widget.dart';
import 'package:greenwaydispatch/login/LoginAuthentication.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ConstrainedBox(constraints: BoxConstraints()),
              Image(
                image: new AssetImage("assets/Greenwaylogo.png"),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone number",
                  border: const OutlineInputBorder(),
                  icon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    icon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        })),
                obscureText: !showPassword,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: _passwordController,
              ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                  child: Container(
                    height: 50,
                    // margin: EdgeInsets.symmetric(horizontal: 60),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: BoxDecoration(
                        // color: Color(0xFF8BC34A),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                  ),
                  onPressed: () {
                    //do something with this login info
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar.
                      // call a server or save the information in a database.

                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Signing up')));
                      handleLogInPage(int.parse(_phoneNumberController.text),
                          _passwordController.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  }),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
