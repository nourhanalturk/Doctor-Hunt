import '../../domain/model/doctor_name_model.dart';
import '../response/get_doctor_response.dart';

extension GetDoctorMapper on GetDoctorResponse {
  DoctorNameModel toDomain() => DoctorNameModel(name: name);
}
