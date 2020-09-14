import 'package:chopper/chopper.dart';
import 'package:greenwaydispatch/loginAndSignUp/login_model/LogIn.dart';

part 'login_api_service.chopper.dart';

@ChopperApi()
abstract class LoginApiService extends ChopperService {
  @Post(path: "/login")
  Future<Response> getResult(@Body() Map<String, dynamic> body);

  @Post(path: "/signup")
  Future<Response> signupUser(@Body() Map<String, String> body);

  static LoginApiService create() {
    final client = ChopperClient(
        baseUrl: "http://10.0.2.2:3000",
        services: [_$LoginApiService()],
        converter: JsonConverter(),
        errorConverter: JsonConverter());
    return _$LoginApiService(client);
  }
}
