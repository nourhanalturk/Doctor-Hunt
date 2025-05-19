import 'package:get/get.dart';
import 'package:tender/features/medical_records/presentation/controller/medical_records_controller.dart';

initMedicalRecords() {
  if (!Get.isRegistered<MedicalRecordsController>()) {
    Get.put<MedicalRecordsController>(MedicalRecordsController());
  }
}

disposeMedicalRecords() {
  if (Get.isRegistered<MedicalRecordsController>()) {
    Get.delete<MedicalRecordsController>();
  }
}
