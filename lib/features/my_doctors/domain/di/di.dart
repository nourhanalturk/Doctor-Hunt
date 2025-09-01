import 'package:get/get.dart';
import 'package:tender/features/my_doctors/presentation/controller/my_doctors_controller.dart';

initMyDoctors() {
  if (!Get.isRegistered<MyDoctorsController>()) {
    Get.put<MyDoctorsController>(MyDoctorsController());
  }
}

disposeMyDoctors() {
  if (Get.isRegistered<MyDoctorsController>()) {
    Get.delete<MyDoctorsController>();
  }
}