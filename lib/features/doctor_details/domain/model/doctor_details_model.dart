import 'sub_home_data_model.dart';

class DoctorDetailsModel {
  final int id;
  final DateTime createdAt;
  final int? doctorId;
  final int? runningPatients;
  final int? outgoingPatients;
  final int? patients;
  final String? location;
  final double? coastPerHour;
  final List<String>? services;
  final SubHomeDataModel? homeData;

  DoctorDetailsModel({
    required this.id,
    required this.createdAt,
    this.doctorId,
    this.runningPatients,
    this.outgoingPatients,
    this.patients,
    this.location,
    this.coastPerHour,
    this.homeData,
    this.services,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DoctorDetailsModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode;
}
