import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:greenwaydispatch/login/login_model/LogIn.dart';
import 'package:greenwaydispatch/login/login_api_service/login_api_service.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoadingLoginState());

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Fetch) {
      Map<String, dynamic> body = {
        "email": event.phoneNumber,
        "password": event.password
      };

      yield LoadingLoginState();

      try {
        final Response response =
            await LoginApiService.create().getResult(body);

        final Login _login = Login.fromJson(response.body);

        yield LoadedLoginState(login: _login);
      } catch (e) {
        yield ErrorLoginState(error: e.toString());
      }
    }
  }
}
