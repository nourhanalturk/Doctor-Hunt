import 'package:tender/core/extensions/extensions.dart';

class AddPatientRequest {
  final String patientId;
  final String fullName;
  final String contactNumber;
  final String? profileImageUrl;

  AddPatientRequest({
    required this.patientId,
    required this.fullName,
    required this.contactNumber,
    this.profileImageUrl,
  });
  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'full_name': fullName,
      'contact_number': contactNumber.onNull(),
      'profile_image_url': profileImageUrl.onNull(),
    };
  }
}
