// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_home_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubHomeDataResponse _$SubHomeDataResponseFromJson(Map<String, dynamic> json) =>
    SubHomeDataResponse(
      name: json['name'] as String?,
      image: json['image'] as String?,
      speciality: json['specialty'] as String?,
      rate: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SubHomeDataResponseToJson(
        SubHomeDataResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'specialty': instance.speciality,
      'rating': instance.rate,
    };
