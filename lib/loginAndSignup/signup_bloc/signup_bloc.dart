import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import '../signup_model/Signup.dart' as signUp;
import 'package:greenwaydispatch/loginAndSignUp/login_api_service/login_api_service.dart';
import './bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(InitialSignupState());

  @override
  SignupState get initialState => InitialSignupState();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is Signup) {
      Map<String, String> body = {
        "firstname": event.firstname,
        "lastname": event.lastname,
        "phone_number": event.phone_number,
        "password": event.password,
        "confirmPassword": event.confirmPassword
      };
      yield LoadingSignupState();

      try {
        final Response response =
            await LoginApiService.create().signupUser(body);

        final signUp.Signup signup = signUp.Signup.fromJson(response.body);
        yield LoadedSignupState(response: signup);
      } catch (e) {
        yield ErrorSignupState(error: e.toString());
      }
    }
  }
}
