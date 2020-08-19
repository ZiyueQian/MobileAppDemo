import 'package:chopper/chopper.dart';
import 'package:greenwaydispatch/loginAndSignUp/login_model/LogIn.dart';

part 'login_api_service.chopper.dart';

@ChopperApi()
abstract class LoginApiService extends ChopperService {
  @Post(path: "/login")
  Future<Response> getResult(@Body() Map<String, dynamic> body);

  @Post(path: "/register")
  Future<Response> registerUser(@Body() Map<String, dynamic> body);

  static LoginApiService create() {
    final client = ChopperClient(
        baseUrl: "https://reqres.in/api",
        services: [_$LoginApiService()],
        converter: JsonConverter(),
        errorConverter: JsonConverter());
    return _$LoginApiService(client);
  }
}
