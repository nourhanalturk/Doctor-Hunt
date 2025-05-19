import 'package:get/get.dart';
import 'package:tender/features/profile/presentation/controller/profile_controller.dart';

initProfile() {
  if (!Get.isRegistered<ProfileController>()) {
    Get.put<ProfileController>(ProfileController());
  }
}

disposeProfile() {
  if (Get.isRegistered<ProfileController>()) {
    Get.delete<ProfileController>();
  }
}