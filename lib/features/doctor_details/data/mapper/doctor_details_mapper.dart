import 'package:tender/features/doctor_details/data/mapper/sub_home_data+mapper.dart';

import '../../domain/model/doctor_details_model.dart';
import '../response/doctor_details_response.dart';

extension DoctorDetailsMapper on DoctorDetailsResponse {
  DoctorDetailsModel toDomain() => DoctorDetailsModel(
    id: id,
    createdAt: createdAt,
    doctorId: doctorId,
    runningPatients: runningPatients,
    outgoingPatients: outgoingPatients,
    patients: patients,
    location: location,
    coastPerHour: coastPerHour,
    homeData: homeDataResponse.toDomain(),
    services: services,
  );
}