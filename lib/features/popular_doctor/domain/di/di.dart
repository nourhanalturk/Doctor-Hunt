import 'package:get/get.dart';
import 'package:tender/features/popular_doctor/presentation/controller/popular_doctors_controller.dart';

initPopularDoctors(){
  if(!Get.isRegistered<PopularDoctorsController>()){
    Get.put<PopularDoctorsController>(PopularDoctorsController());
  }
}

disposePopularDoctors(){
  if(Get.isRegistered<PopularDoctorsController>()){
    Get.delete<PopularDoctorsController>();
  }
}