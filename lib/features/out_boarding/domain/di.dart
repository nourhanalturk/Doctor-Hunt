import 'package:get/get.dart';
import 'package:tender/features/out_boarding/presentation/controller/out_boarding_controller.dart';
import 'package:tender/features/splash/domain/di.dart';
import 'package:tender/features/splash/presentation/controller/splash_controller.dart';

initOutBoarding(){
  disposeSplash();
  if(!Get.isRegistered<OutBoardingController>()){
    Get.put<OutBoardingController>(OutBoardingController());
  }
}
disposeOutBoarding(){
  if(Get.isRegistered<OutBoardingController>()){
    Get.delete<OutBoardingController>();
  }
}