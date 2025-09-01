import 'package:get/get.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';
import 'package:tender/features/profile/domain/di/di.dart';

initMainContainer() {
  disposeProfile();
  if (!Get.isRegistered<MainContainerController>()) {
    Get.put<MainContainerController>(MainContainerController());
  }
}

disposeMainContainer() {
  if (Get.isRegistered<MainContainerController>()) {
    Get.delete<MainContainerController>();
  }
}
