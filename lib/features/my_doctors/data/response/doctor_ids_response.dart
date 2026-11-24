import '../../../../config/constants/supabase_fields_constants.dart';

class DoctorIdsResponse {
  final int? doctorId;

  DoctorIdsResponse({this.doctorId});

  factory DoctorIdsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorIdsResponse(
      doctorId: json[SupabaseFieldsConstants.doctorId],
    );
  }
}
