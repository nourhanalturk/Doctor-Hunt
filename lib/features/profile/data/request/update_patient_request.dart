import 'package:tender/config/constants/supabase_fields_constants.dart';

class UpdatePatientRequest {
  final String patientId;
  final String name;
  final String contactNumber;
  final String imageUrl;

  UpdatePatientRequest({
    required this.patientId,
    required this.name,
    required this.contactNumber,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        SupabaseFieldsConstants.fullName: name,
        SupabaseFieldsConstants.contactNumber: contactNumber,
        SupabaseFieldsConstants.profileImageUrl: imageUrl,
      };
}
