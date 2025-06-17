import 'package:get/get.dart';
import 'package:tender/features/privacy_and_policy/presentation/controller/privacy_and_policy_controller.dart';

initPrivacy() {
  if (!Get.isRegistered<PrivacyAndPolicyController>()) {
    Get.put<PrivacyAndPolicyController>(PrivacyAndPolicyController());
  }
}

disposePrivacy() {
  if (Get.isRegistered<PrivacyAndPolicyController>()) {
    Get.delete<PrivacyAndPolicyController>();
  }
}