import 'package:get/get.dart';
import 'package:tender/features/main_container/domain/di/di.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';
import 'package:tender/features/out_boarding/domain/di.dart';
import '../../../doctor_appointment/domain/di/di.dart';
import '../../../login/domain/di/di.dart';
import '../../../main_container/presentation/controller/main_container_controller.dart';
import '../../../register/domain/di/di.dart';
import '../../../splash/domain/di.dart';

initMainHome() {
  disposeDoctorAppointments();
  disposeRegister();
  disposeLogin();
  disposeSplash();
  disposeOutBoarding();
  Get.put(MainContainerController());

  if (!Get.isRegistered<MainHomeController>()) {
    Get.put<MainHomeController>(MainHomeController());
  }
}

disposeMainHome() {
  if (Get.isRegistered<MainHomeController>()) {
    Get.delete<MainHomeController>();
  }
}
