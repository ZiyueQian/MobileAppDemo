import 'package:meta/meta.dart';
import 'package:greenwaydispatch/loginAndSignUp/login_model/LogIn.dart';

@immutable
abstract class LoginEvent {}

class Fetch extends LoginEvent {
  final String phone_number;
  final String password;

  Fetch({@required this.phone_number, @required this.password});
}

class LoggedOut extends LoginEvent {
  @override
  String toString() => 'LoggedOut';
}

class LoggedIn extends LoginEvent {
  final Login login;

  LoggedIn({@required this.login});

  @override
  String toString() => 'LoggedIn { login: $login }';
}
