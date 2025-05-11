import 'package:get/get.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';
import '../../../doctor_appointment/model/di/di.dart';

initMainHome() {
  disposeDoctorAppointments();
  if (!Get.isRegistered<MainHomeController>()) {
    Get.put<MainHomeController>(MainHomeController());
  }
}

disposeMainHome() {
  if (Get.isRegistered<MainHomeController>()) {
    Get.delete<MainHomeController>();
  }
}
