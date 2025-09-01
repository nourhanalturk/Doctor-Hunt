import 'package:tender/config/constants/supabase_fields_constants.dart';

class DoctorDataModel {
  int? doctorId ;
  String? doctorName;
  String? image;

  DoctorDataModel({
    required this.doctorId,
    required this.doctorName,
    required this.image,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      doctorId: json[SupabaseFieldsConstants.id],
      doctorName: json[SupabaseFieldsConstants.name],
      image: json[SupabaseFieldsConstants.image],
    );
  }
}
