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
      'doctor_id': doctorId,
      'patient_id': patientId,
      'appointment_time': appointmentTime.toIso8601String(),
      'status': status,
      'dependent_name': dependentName,
      'contact_number': contactNumber,
      'dependent_image_url': dependentImageUrl,
    };
  }
}