import 'package:tender/core/enums/section_enum.dart';

class HomeModel {
  final int id;
  final DateTime createdAt;
  final SectionType section;
  final String? name;
  final String? image;
  final bool? isLive;
  final String? specialty;
  final double? rating;
  final double? coastPerHour;

  HomeModel({
    required this.id,
    required this.createdAt,
    required this.section,
    this.name,
    this.image,
    this.isLive,
    this.specialty,
    this.rating,
    this.coastPerHour,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HomeModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode;
}