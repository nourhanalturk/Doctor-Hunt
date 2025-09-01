import 'package:get/get.dart';
import 'package:tender/features/splash/presentation/controller/splash_controller.dart';

initSplash(){
  if(!Get.isRegistered<SplashController>()){
    Get.put<SplashController>(SplashController());
  }
}
disposeSplash(){
  if(Get.isRegistered<SplashController>()){
    Get.delete<SplashController>();
  }
}