import 'package:json_annotation/json_annotation.dart';
import 'package:tender/config/constants/response_constants.dart';
import 'package:tender/features/doctor_details/data/response/sub_home_data_response.dart';

part 'doctor_details_response.g.dart';

@JsonSerializable()
class DoctorDetailsResponse {
  @JsonKey(name: ResponseConstants.id)
  final int id;

  @JsonKey(
      name: ResponseConstants.createdAt, fromJson: _fromJson, toJson: _toJson)
  final DateTime createdAt;

  @JsonKey(name: ResponseConstants.doctorId)
  final int? doctorId;
  @JsonKey(name: ResponseConstants.runningPatients)
  final int? runningPatients;

  @JsonKey(name: ResponseConstants.outgoingPatients)
  final int? outgoingPatients;
  @JsonKey(name: ResponseConstants.patients)
  final int? patients;

  @JsonKey(name: ResponseConstants.location)
  final String? location;
  @JsonKey(name: ResponseConstants.coastPerHour)
  final double? coastPerHour;
  @JsonKey(name: ResponseConstants.services)
  final List<String>? services;

  @JsonKey(name: 'home_data')
  SubHomeDataResponse homeDataResponse ;

  DoctorDetailsResponse({
    required this.id,
    required this.createdAt,
    required this.doctorId,
    required this.runningPatients,
    required this.outgoingPatients,
    required this.patients,
    required this.location,
    required this.coastPerHour,
    required this.homeDataResponse,
    required this.services,
  });

  factory DoctorDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailsResponseFromJson(json);

  static DateTime _fromJson(String date) => DateTime.parse(date);

  static String _toJson(DateTime date) => date.toIso8601String();
}
