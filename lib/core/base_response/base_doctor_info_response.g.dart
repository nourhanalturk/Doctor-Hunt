// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_doctor_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDoctorInfoResponse _$BaseDoctorInfoResponseFromJson(
        Map<String, dynamic> json) =>
    BaseDoctorInfoResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$BaseDoctorInfoResponseToJson(
        BaseDoctorInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
