import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants/response_constants.dart';
import '../../../../core/base_response/base_response.dart';

part 'add_patient_response.g.dart';

@JsonSerializable()
class PatientsResponse  {
  @JsonKey(name: ResponseConstants.patientId)
  String? patientId;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.contactNumber)
  String? contactNumber;

  @JsonKey(name: ResponseConstants.profileImageUrl)
  String? profileImageUrl;

  @JsonKey(name: ResponseConstants.createdAt, fromJson: _fromJson, toJson: _toJson)
  DateTime? createdAt;

  PatientsResponse({
    this.patientId,
    this.fullName,
    this.contactNumber,
    this.profileImageUrl,
    this.createdAt,
    String? status,
    String? message,
  }) ;

  factory PatientsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientsResponseToJson(this);

  static DateTime _fromJson(String timestamp) => DateTime.parse(timestamp);
  static String _toJson(DateTime? time) => time?.toIso8601String() ?? '';
}