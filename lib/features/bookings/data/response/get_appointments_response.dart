import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants/response_constants.dart';

part 'get_appointments_response.g.dart';

@JsonSerializable()
class GetAppointmentsResponse {
  @JsonKey(name: ResponseConstants.appointmentId)
  String? appointmentId;

  @JsonKey(name: ResponseConstants.doctorId)
  int? doctorId;

  @JsonKey(name: ResponseConstants.patientId)
  String? patientId;

  @JsonKey(name: ResponseConstants.appointmentTime, fromJson: _fromJson, toJson: _toJson)
  DateTime? appointmentTime;

  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.dependentName)
  String? dependentName;

  @JsonKey(name: ResponseConstants.contactNumber)
  String? contactNumber;

  @JsonKey(name: ResponseConstants.dependentImageUrl)
  String? dependentImageUrl;

  @JsonKey(name: ResponseConstants.createdAt, fromJson: _fromJson, toJson: _toJson)
  DateTime? createdAt;

  GetAppointmentsResponse({
    this.appointmentId,
    this.doctorId,
    this.patientId,
    this.appointmentTime,
    this.status,
    this.dependentName,
    this.contactNumber,
    this.dependentImageUrl,
    this.createdAt,
  });

  factory GetAppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAppointmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppointmentsResponseToJson(this);

  static DateTime _fromJson(String timestamp) => DateTime.parse(timestamp);
  static String _toJson(DateTime? time) => time?.toIso8601String() ?? '';
}
