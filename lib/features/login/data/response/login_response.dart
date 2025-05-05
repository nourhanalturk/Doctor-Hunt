import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants/response_constants.dart';
import '../../../../core/base_response/base_response.dart';
import 'login_data_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  @JsonKey(name: ResponseConstants.data)
  LoginDataResponse? data;

  LoginResponse({
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
