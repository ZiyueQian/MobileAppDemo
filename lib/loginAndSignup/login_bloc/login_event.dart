import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class Fetch extends LoginEvent {
  final String phone_number;
  final String password;

  Fetch({@required this.phone_number, @required this.password});
}
