import '../../../../config/constants/supabase_fields_constants.dart';

class DoctorDataResponse {
  final int? doctorId;
  final String? doctorName;
  final String? image;

  DoctorDataResponse({this.doctorId, this.doctorName, this.image});

  factory DoctorDataResponse.fromJson(Map<String, dynamic> json) {
    return DoctorDataResponse(
      doctorId: json[SupabaseFieldsConstants.id],
      doctorName: json[SupabaseFieldsConstants.name],
      image: json[SupabaseFieldsConstants.image],
    );
  }
}
