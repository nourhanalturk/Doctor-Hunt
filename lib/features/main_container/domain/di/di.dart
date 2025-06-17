import 'package:get/get.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';

initMainContainer() {
  if (!Get.isRegistered<MainContainerController>()) {
    Get.put<MainContainerController>(MainContainerController());
  }
}

disposeMainContainer() {
  if (Get.isRegistered<MainContainerController>()) {
    Get.delete<MainContainerController>();
  }
}
