import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class Fetch extends LoginEvent {
  final String phoneNumber;
  final String password;

  Fetch({@required this.phoneNumber, @required this.password});
}
