import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/home_widget.dart';
import '../signup_bloc/bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  SignupBloc signupBloc;

  @override
  void initState() {
    super.initState();
    signupBloc = SignupBloc();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "First name",
                      border: const OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    controller: _firstNameController,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Last name",
                      border: const OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: _lastNameController,
                  ),
                  SizedBox(
                    height: 16.0,
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
                  ),
                  SizedBox(
                    height: 16.0,
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
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        icon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            icon: Icon(
                              showConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                showConfirmPassword = !showConfirmPassword;
                              });
                            })),
                    obscureText: !showConfirmPassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    controller: _confirmPasswordController,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  BlocBuilder(
                      cubit: signupBloc,
                      builder: (context, state) {
                        if (state is LoadingSignupState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is LoadedSignupState) {
                          return Text("Success " + state.response.token);
                        }
                        if (state is ErrorSignupState) {
                          return Text("Error " + state.error);
                        } else {
                          return Container();
                        }
                      }),
                  FlatButton(
                      child: Container(
                        height: 50,
                        // margin: EdgeInsets.symmetric(horizontal: 60),
                        child: Center(
                          child: Text(
                            "SIGN UP",
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
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar.
                          // call a server or save the information in a database.

//                        Scaffold.of(context).showSnackBar(
//                            SnackBar(content: Text('Processing Data')));
//                        handleSignUpPage(
//                            _firstNameController.text,
//                            _lastNameController.text,
//                            int.parse(_phoneNumberController.text),
//                            _confirmPasswordController.text);

                          signupBloc.add(Signup(
                              firstname: _firstNameController.text,
                              lastname: _lastNameController.text,
                              phone_number: _phoneNumberController.text,
                              password: _passwordController.text,
                              confirmPassword:
                                  _confirmPasswordController.text));

//                        Navigator.of(context)
//                            .popUntil((route) => route.isFirst);
                        }
                        //do something with this signup info
                      }),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
