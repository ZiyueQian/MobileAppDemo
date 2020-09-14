import 'package:json_annotation/json_annotation.dart';

part 'LogIn.g.dart';

@JsonSerializable(nullable: false)
class Login {
  String token;

  Login({this.token}); //"QpwL5tke4Pnpja7X4"

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
