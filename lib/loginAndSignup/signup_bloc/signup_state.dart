import 'package:meta/meta.dart';
import '../signup_model/Signup.dart';

@immutable
abstract class SignupState {}

class InitialSignupState extends SignupState {}

class LoadingSignupState extends SignupState {}

class LoadedSignupState extends SignupState {
  final Signup response;

  LoadedSignupState({@required this.response});
}

class ErrorSignupState extends SignupState {
  final String error;

  ErrorSignupState({@required this.error});
}
