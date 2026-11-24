import 'package:tender/config/constants/supabase_fields_constants.dart';

class AddMedicalRecordRequest {
  final String recordFor;
  final String diseaseName;
  final String description;
  final String doctorName;
  final String medicineNames;
  final String reportDate;
  final List<String> imageUrls;

  AddMedicalRecordRequest({
    required this.recordFor,
    required this.diseaseName,
    required this.description,
    required this.doctorName,
    required this.medicineNames,
    required this.reportDate,
    required this.imageUrls,
  });

  Map<String, dynamic> toJson() => {
        SupabaseFieldsConstants.recordFor: recordFor,
        SupabaseFieldsConstants.diseaseName: diseaseName,
        SupabaseFieldsConstants.description: description,
        SupabaseFieldsConstants.doctorName: doctorName,
        SupabaseFieldsConstants.medicineNames: medicineNames,
        SupabaseFieldsConstants.reportDate: reportDate,
        SupabaseFieldsConstants.imageUrls: imageUrls,
      };
}
