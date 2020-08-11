import 'LogIn.dart';
import 'package:flutter/cupertino.dart';

void handleSignUpPage(
    String firstName, String lastName, int phoneNumber, String password) {
  String _firstName = firstName;
  String _lastName = lastName;
  int _phoneNumber = phoneNumber;
  String _password = password;

  print(_firstName);
  print(_lastName);
  print(_phoneNumber);
  print(_password);

//  @override
//  void onResponse(Call<Void> call, Response<Void> response) {
//  if (response.code() == 200) {
//  //confirmPasswordEdit.onEditorAction(EditorInfo.IME_ACTION_DONE);
//  Scaffold.of(context).showSnackBar(
//      SnackBar(content: Text('Signed Up Successfully')));
//  }
//  else if (response.code() == 400)
//  Toast.makeText(MainActivity.this, "User Already Exist",
//  Toast.LENGTH_LONG).show();
//  else if (response.code() == 401)
//  Toast.makeText(MainActivity.this, "Password Not Match",
//  Toast.LENGTH_LONG).show();
//  }
//
//  @Override
//  public void onFailure(Call<Void> call, Throwable t) {
//  Toast.makeText(MainActivity.this, t.getMessage(),
//  Toast.LENGTH_LONG).show();
//  }
}
