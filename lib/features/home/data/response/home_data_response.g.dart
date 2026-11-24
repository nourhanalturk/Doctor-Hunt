// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      id: (json['id'] as num).toInt(),
      createdAt: HomeResponse._fromJson(json['created_at'] as String),
      section: HomeResponse._sectionFromJson(json['section'] as String),
      name: json['name'] as String?,
      image: json['image'] as String?,
      isLive: json['is_live'] as bool?,
      specialty: json['specialty'] as String?,
      coastPerHour: (json['coast_per_hour'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': HomeResponse._toJson(instance.createdAt),
      'section': _$SectionTypeEnumMap[instance.section]!,
      'name': instance.name,
      'image': instance.image,
      'is_live': instance.isLive,
      'specialty': instance.specialty,
      'rating': instance.rating,
      'coast_per_hour': instance.coastPerHour,
    };

const _$SectionTypeEnumMap = {
  SectionType.live_doctors: 'live_doctors',
  SectionType.popular_doctors: 'popular_doctors',
  SectionType.featured_doctors: 'featured_doctors',
  SectionType.unknown: 'unknown',
};
