class FavoriteDoctorModel {
  final String userId;
  final int doctorId;
  final String name;
  final String image;
  final String specialty;

  FavoriteDoctorModel({
    required this.userId,
    required this.doctorId,
    required this.name,
    required this.image,
    required this.specialty,
  });

  factory FavoriteDoctorModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDoctorModel(
      userId: json['user_id'] as String,
      doctorId: json['doctor_id'] as int,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      specialty: json['specialty'] ?? '',
    );
  }
}
