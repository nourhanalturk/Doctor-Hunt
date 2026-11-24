import '../../domain/model/patient_records_model.dart';
import '../response/patient_record_response.dart';

extension PatientRecordsMapper on PatientRecordResponse {
  PatientRecordsModel toDomain() => PatientRecordsModel(
        diseaseName: diseaseName,
        description: description,
        doctorName: doctorName,
        reportDate: reportDate,
        medicineNames: medicineNames,
        imageUrls: imageUrls,
        recordFor: recordFor,
      );
}
