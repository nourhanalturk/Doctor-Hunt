import '../../domain/model/patient_model.dart';
import '../response/patient_response.dart';

extension PatientMapper on PatientResponse {
  PatientModel toDomain() => PatientModel(
        fullName: fullName,
        contactNumber: contactNumber,
        image: image,
      );
}
