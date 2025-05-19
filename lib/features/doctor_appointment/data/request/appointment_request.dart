import '../../../../config/constants/supabase_fields_constants.dart';

class AddAppointmentRequest {
  final int doctorId;
  final String patientId;
  final DateTime appointmentTime;
  final String? status;
  final String? dependentName;
  final String? contactNumber;
  final String? dependentImageUrl;

  AddAppointmentRequest({
    required this.doctorId,
    required this.patientId,
    required this.appointmentTime,
    this.status,
    this.dependentName,
    this.contactNumber,
    this.dependentImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      SupabaseFieldsConstants.doctorId: doctorId,
      SupabaseFieldsConstants.patientId: patientId,
      SupabaseFieldsConstants.appointmentTime: appointmentTime.toIso8601String(),
      SupabaseFieldsConstants.status: status,
      SupabaseFieldsConstants.dependentName: dependentName,
      SupabaseFieldsConstants.contactNumber: contactNumber,
      SupabaseFieldsConstants.dependentImageUrl: dependentImageUrl,
    };
  }
}