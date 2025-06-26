import 'package:get/get.dart';
import 'package:tender/features/home/domain/di/di.dart';

import '../../presentation/controller/profile_records_info_controller.dart';

initProfileRecordsInfo() {
  disposeHome();
  if (!Get.isRegistered<ProfileRecordsInfoController>()) {
    Get.put(ProfileRecordsInfoController());
  }
}

disposeProfileRecordsInfo() {
  if (Get.isRegistered<ProfileRecordsInfoController>()) {
    Get.delete<ProfileRecordsInfoController>();
  }
}