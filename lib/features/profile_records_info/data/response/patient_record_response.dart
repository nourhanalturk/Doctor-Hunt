import 'package:tender/config/constants/supabase_fields_constants.dart';

class PatientRecordResponse {
  final String? diseaseName;
  final String? description;
  final String? doctorName;
  final dynamic reportDate;
  final String? medicineNames;
  final List<dynamic>? imageUrls;
  final String? recordFor;

  PatientRecordResponse({
    this.diseaseName,
    this.description,
    this.doctorName,
    this.reportDate,
    this.medicineNames,
    this.imageUrls,
    this.recordFor,
  });

  factory PatientRecordResponse.fromJson(Map<String, dynamic> json) {
    return PatientRecordResponse(
      diseaseName: json[SupabaseFieldsConstants.diseaseName] as String?,
      description: json[SupabaseFieldsConstants.description] as String?,
      doctorName: json[SupabaseFieldsConstants.doctorName] as String?,
      reportDate: json[SupabaseFieldsConstants.reportDate],
      medicineNames: json[SupabaseFieldsConstants.medicineNames] as String?,
      imageUrls: json[SupabaseFieldsConstants.imageUrls] as List<dynamic>?,
      recordFor: json[SupabaseFieldsConstants.recordFor] as String?,
    );
  }
}
