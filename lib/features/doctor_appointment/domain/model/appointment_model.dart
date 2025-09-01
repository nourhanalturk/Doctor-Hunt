class AppointmentModel {
  final String appointmentId;
  final int doctorId;
  final String patientId;
  final DateTime appointmentTime;
  final String status;
  final String? dependentName;
  final String? contactNumber;
  final String? dependentImageUrl;
  final DateTime createdAt;

  AppointmentModel({
    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.appointmentTime,
    required this.status,
    this.dependentName,
    this.contactNumber,
    this.dependentImageUrl,
    required this.createdAt,
  });
}