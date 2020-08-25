import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:greenwaydispatch/loginAndSignUp/login_model/LogIn.dart';

@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoadedLoginState extends LoginState {
  final Login login;

  LoadedLoginState({@required this.login});
}

class ErrorLoginState extends LoginState {
  final String error;

  ErrorLoginState({@required this.error});
}
