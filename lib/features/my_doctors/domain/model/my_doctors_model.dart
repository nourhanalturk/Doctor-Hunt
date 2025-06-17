import 'package:tender/config/constants/supabase_fields_constants.dart';

class MyDoctorsModel {
  String doctorName;
  String image;

  MyDoctorsModel({
    required this.doctorName,
    required this.image,
  });

  factory MyDoctorsModel.fromJson(Map<String, dynamic> json) {
    return MyDoctorsModel(
      doctorName: json[SupabaseFieldsConstants.name],
      image: json[SupabaseFieldsConstants.image],
    );
  }
}
