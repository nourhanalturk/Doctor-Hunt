import 'package:get/get.dart';
import 'package:tender/features/health-checkups/presentation/controller/health_checkups_controller.dart';

initHealthCheckups(){
  if(!Get.isRegistered<HealthCheckupsController>()){
    Get.put<HealthCheckupsController>(HealthCheckupsController());
  }
}
disposeHealthCheckups(){
  if(Get.isRegistered<HealthCheckupsController>()){
    Get.delete<HealthCheckupsController>();
  }
}