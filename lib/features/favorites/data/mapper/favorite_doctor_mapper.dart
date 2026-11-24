import '../../domain/model/favorite_doctor_model.dart';
import '../response/favorite_doctor_response.dart';

extension FavoriteDoctorMapper on FavoriteDoctorResponse {
  FavoriteDoctorModel toDomain() => FavoriteDoctorModel(
        userId: userId,
        doctorId: doctorId,
        name: name,
        image: image,
        specialty: specialty,
      );
}
