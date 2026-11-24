import '../../domain/model/my_doctors_model.dart';
import '../response/my_doctors_response.dart';

extension MyDoctorsMapper on MyDoctorsResponse {
  MyDoctorsModel toDomain() => MyDoctorsModel(
        doctorName: name,
        image: image,
      );
}
