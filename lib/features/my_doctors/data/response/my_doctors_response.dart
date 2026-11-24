import '../../../../config/constants/supabase_fields_constants.dart';

class MyDoctorsResponse {
  final String name;
  final String image;

  MyDoctorsResponse({required this.name, required this.image});

  factory MyDoctorsResponse.fromJson(Map<String, dynamic> json) {
    return MyDoctorsResponse(
      name: json[SupabaseFieldsConstants.name] as String? ?? '',
      image: json[SupabaseFieldsConstants.image] as String? ?? '',
    );
  }
}
