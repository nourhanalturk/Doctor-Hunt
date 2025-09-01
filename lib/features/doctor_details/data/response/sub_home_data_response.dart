import 'package:json_annotation/json_annotation.dart';
import 'package:tender/config/constants/response_constants.dart';

part 'sub_home_data_response.g.dart';

@JsonSerializable()
class SubHomeDataResponse {
  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

  @JsonKey(name: ResponseConstants.specialty)
  final String? speciality;

  @JsonKey(name: ResponseConstants.rating)
  final double? rate;

  SubHomeDataResponse({
    this.name,
    this.image,
    this.speciality,
    this.rate,
  });

  factory SubHomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SubHomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubHomeDataResponseToJson(this);
}
