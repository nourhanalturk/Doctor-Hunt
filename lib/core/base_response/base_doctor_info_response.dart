import 'package:json_annotation/json_annotation.dart';

part 'base_doctor_info_response.g.dart';

@JsonSerializable()
class BaseDoctorInfoResponse {
  final int? id;
  final String? name;
  final String? image;

  BaseDoctorInfoResponse({
    this.id,
    this.name,
    this.image,
  });

  factory BaseDoctorInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseDoctorInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDoctorInfoResponseToJson(this);
}
