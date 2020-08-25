import 'package:meta/meta.dart';

@immutable
abstract class SignupEvent {}

class Signup extends SignupEvent {
  final String firstname;
  final String lastname;
  final String phone_number;
  final String password;
  final String confirmPassword;

  Signup(
      {@required this.firstname,
      @required this.lastname,
      @required this.phone_number,
      @required this.password,
      @required this.confirmPassword});
}
