import 'package:get/get.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';

initMainHome() {
  if (!Get.isRegistered<MainHomeController>()) {
    Get.put<MainHomeController>(MainHomeController());
  }
}

disposeMainHome() {
  if (Get.isRegistered<MainHomeController>()) {
    Get.delete<MainHomeController>();
  }
}
