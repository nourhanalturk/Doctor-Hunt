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
}
