import 'package:json_annotation/json_annotation.dart';
import 'package:tender/config/constants/response_constants.dart';

import '../../../../core/enums/section_enum.dart';

part 'home_data_response.g.dart';

@JsonSerializable()
class HomeResponse {
  @JsonKey(name: ResponseConstants.id)
  final int id;

  @JsonKey(
      name: ResponseConstants.createdAt, fromJson: _fromJson, toJson: _toJson)
  final DateTime createdAt;

  @JsonKey(name: ResponseConstants.section, fromJson: _sectionFromJson)
  final SectionType section;

  @JsonKey(name: ResponseConstants.name)
  final String? name;
  @JsonKey(name: ResponseConstants.image)
  final String? image;

  @JsonKey(name: ResponseConstants.isLive)
  final bool? isLive;
  @JsonKey(name: ResponseConstants.specialty)
  final String? specialty;
  @JsonKey(name: ResponseConstants.rating)
  final double? rating;
  @JsonKey(name: ResponseConstants.coastPerHour)
  final double? coastPerHour;

  HomeResponse({
    required this.id,
    required this.createdAt,
    required this.section,
    this.name,
    this.image,
    this.isLive,
    this.specialty,
    this.coastPerHour,
    this.rating,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  static DateTime _fromJson(String date) => DateTime.parse(date);

  static String _toJson(DateTime date) => date.toIso8601String();

  static SectionType _sectionFromJson(String value) =>
      SectionType.fromString(value);
}
