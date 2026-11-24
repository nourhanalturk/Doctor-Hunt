import 'package:tender/config/constants/response_constants.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';

class FavoriteDoctorResponse {
  final String userId;
  final int doctorId;
  final String name;
  final String image;
  final String specialty;

  FavoriteDoctorResponse({
    required this.userId,
    required this.doctorId,
    required this.name,
    required this.image,
    required this.specialty,
  });

  factory FavoriteDoctorResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteDoctorResponse(
      userId: json[SupabaseFieldsConstants.userId] as String? ?? '',
      doctorId: json[SupabaseFieldsConstants.doctorId] as int? ?? 0,
      name: json[SupabaseFieldsConstants.name] as String? ?? '',
      image: json[SupabaseFieldsConstants.image] as String? ?? '',
      specialty: json[ResponseConstants.specialty] as String? ?? '',
    );
  }
}
