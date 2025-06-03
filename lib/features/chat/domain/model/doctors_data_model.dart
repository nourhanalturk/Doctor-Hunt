import 'package:tender/config/constants/supabase_fields_constants.dart';

class DoctorDataModel {
  String? doctorName;
  String? image;

  DoctorDataModel({
    required this.doctorName,
    required this.image,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      doctorName: json['name'],
      image: json[SupabaseFieldsConstants.image],
    );
  }
}
