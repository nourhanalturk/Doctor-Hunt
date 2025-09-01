import 'package:get/get.dart';
import 'package:tender/features/settings/presentation/controller/settings_controller.dart';

initSettings(){
  if(!Get.isRegistered<SettingsController>()){
    Get.put<SettingsController>(SettingsController());
  }
}

disposeSettings(){
  if(Get.isRegistered<SettingsController>()){
    Get.delete<SettingsController>();
  }
}