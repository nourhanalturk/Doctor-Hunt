import 'package:tender/config/constants/supabase_fields_constants.dart';

class PatientResponse {
  final String? fullName;
  final String? contactNumber;
  final String? image;

  PatientResponse({
    this.fullName,
    this.contactNumber,
    this.image,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) => PatientResponse(
        fullName: json[SupabaseFieldsConstants.fullName] as String?,
        contactNumber: json[SupabaseFieldsConstants.contactNumber] as String?,
        image: json[SupabaseFieldsConstants.profileImageUrl] as String?,
      );
}
