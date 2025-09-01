import 'package:tender/core/extensions/extensions.dart';

import '../../domain/model/patients_model.dart';
import '../response/add_patient_response.dart';

extension PatientMapper on PatientsResponse {
  PatientModel toDomain() => PatientModel(
        patientId: patientId.onNull(),
        fullName: fullName.onNull(),
        contactNumber: contactNumber.onNull(),
        profileImageUrl: profileImageUrl.onNull(),
        createdAt: createdAt.onNull(),
      );
}
