class PatientModel {
  final String patientId;
  final DateTime createdAt;
  final String fullName;
  final String contactNumber;
  final String? profileImageUrl;

  PatientModel({
    required this.patientId,
    required this.createdAt,
    required this.fullName,
    required this.contactNumber,
    this.profileImageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PatientModel &&
              runtimeType == other.runtimeType &&
              patientId == other.patientId &&
              createdAt == other.createdAt;

  @override
  int get hashCode => patientId.hashCode ^ createdAt.hashCode;
}