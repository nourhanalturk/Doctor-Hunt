// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_patient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientsResponse _$PatientsResponseFromJson(Map<String, dynamic> json) =>
    PatientsResponse(
      patientId: json['patient_id'] as String?,
      fullName: json['full_name'] as String?,
      contactNumber: json['contact_number'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      createdAt: PatientsResponse._fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$PatientsResponseToJson(PatientsResponse instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'full_name': instance.fullName,
      'contact_number': instance.contactNumber,
      'profile_image_url': instance.profileImageUrl,
      'created_at': PatientsResponse._toJson(instance.createdAt),
    };
