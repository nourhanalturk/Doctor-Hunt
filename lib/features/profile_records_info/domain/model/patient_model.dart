import 'package:tender/config/constants/supabase_fields_constants.dart';

class PatientModel {
  String? fullName;
  String? contactNumber;

  String? image;

  PatientModel({
    required this.fullName,
    required this.contactNumber,
    required this.image,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        fullName: json[SupabaseFieldsConstants.fullName],
        contactNumber: json[SupabaseFieldsConstants.contactNumber],
        image: json[SupabaseFieldsConstants.profileImageUrl],
      );
}
