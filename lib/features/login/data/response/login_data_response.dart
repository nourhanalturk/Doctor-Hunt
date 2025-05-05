import 'package:json_annotation/json_annotation.dart';

import '../../../../config/constants/response_constants.dart';

part 'login_data_response.g.dart';

@JsonSerializable()
class LoginDataResponse {
  @JsonKey(name: ResponseConstants.token)
  String? token;

  LoginDataResponse({
    this.token,
  });

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataResponseToJson(this);
}
