import 'LogIn.dart';
import 'package:flutter/cupertino.dart';

void handleLogInPage(int phoneNumber, String password) {
  int _phoneNumber = phoneNumber;
  String _password = password;

  print(_phoneNumber);
  print(_password);

  //@override
//  void onResponse(Call<LogIn> call, Response<LogIn> response) {
//
//  if (response.code() == 404)
//  Toast.makeText(MainActivity.this, "User Doesn't Exist",
//  Toast.LENGTH_LONG).show();
//
//  else if (response.code() == 400)
//  Toast.makeText(MainActivity.this, "Wrong Password",
//  Toast.LENGTH_LONG).show();
//
//  else{
//  LogIn user = response.body();
//  myUser = response.body();
//
//  passwordEdit.onEditorAction(EditorInfo.IME_ACTION_DONE);
//
//  startActivity(new Intent(MainActivity.this, HomeActivity.class) );
//
//  }
//
//  }
//
//  @override
//  void onFailure(Call<LogIn> call, Throwable t) {
//  //Toast.makeText(MainActivity.this, t.getMessage(),
//  //Toast.LENGTH_LONG).show();
//  Toast.makeText(MainActivity.this, "here",
//  Toast.LENGTH_LONG).show();
//  }
}
