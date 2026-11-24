// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDetailsResponse _$DoctorDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    DoctorDetailsResponse(
      id: (json['id'] as num).toInt(),
      createdAt: DoctorDetailsResponse._fromJson(json['created_at'] as String),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      runningPatients: (json['running_patient'] as num?)?.toInt(),
      outgoingPatients: (json['ongoing_patient'] as num?)?.toInt(),
      patients: (json['patient'] as num?)?.toInt(),
      location: json['location'] as String,
      coastPerHour: (json['coast_per_hour'] as num?)?.toDouble(),
      homeDataResponse: SubHomeDataResponse.fromJson(
          json['home_data'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DoctorDetailsResponseToJson(
        DoctorDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': DoctorDetailsResponse._toJson(instance.createdAt),
      'doctor_id': instance.doctorId,
      'running_patient': instance.runningPatients,
      'ongoing_patient': instance.outgoingPatients,
      'patient': instance.patients,
      'location': instance.location,
      'coast_per_hour': instance.coastPerHour,
      'services': instance.services,
      'home_data': instance.homeDataResponse,
    };
