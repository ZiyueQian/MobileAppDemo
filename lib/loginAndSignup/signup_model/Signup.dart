import 'package:json_annotation/json_annotation.dart';

part 'Signup.g.dart';

@JsonSerializable(nullable: false)
class Signup {
  int id; //: 4
  String token;

  Signup({this.id, this.token}); //": "QpwL5tke4Pnpja7X4"

  factory Signup.fromJson(Map<String, dynamic> json) => _$SignupFromJson(json);

  Map<String, dynamic> toJson() => _$SignupToJson(this);
}
