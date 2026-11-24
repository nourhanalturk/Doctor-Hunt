import '../../../../config/constants/supabase_fields_constants.dart';

class GetDoctorResponse {
  final String name;

  GetDoctorResponse({required this.name});

  factory GetDoctorResponse.fromJson(Map<String, dynamic> json) {
    return GetDoctorResponse(
      name: json[SupabaseFieldsConstants.name] as String? ?? '',
    );
  }
}
