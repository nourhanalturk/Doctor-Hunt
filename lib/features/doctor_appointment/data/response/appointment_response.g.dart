// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAppointmentResponse _$AddAppointmentResponseFromJson(
        Map<String, dynamic> json) =>
    AddAppointmentResponse(
      appointmentId: json['appointment_id'] as String?,
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      patientId: json['patient_id'] as String?,
      appointmentTime:
          AddAppointmentResponse._fromJson(json['appointment_time'] as String),
      status: json['status'] as String?,
      dependentName: json['dependent_name'] as String?,
      contactNumber: json['contact_number'] as String?,
      dependentImageUrl: json['dependent_image_url'] as String?,
      createdAt: AddAppointmentResponse._fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$AddAppointmentResponseToJson(
        AddAppointmentResponse instance) =>
    <String, dynamic>{
      'appointment_id': instance.appointmentId,
      'doctor_id': instance.doctorId,
      'patient_id': instance.patientId,
      'appointment_time':
          AddAppointmentResponse._toJson(instance.appointmentTime),
      'status': instance.status,
      'dependent_name': instance.dependentName,
      'contact_number': instance.contactNumber,
      'dependent_image_url': instance.dependentImageUrl,
      'created_at': AddAppointmentResponse._toJson(instance.createdAt),
    };
