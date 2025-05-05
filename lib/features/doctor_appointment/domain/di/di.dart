import 'package:get/get.dart';
import '../../presentation/controller/doctor_appointment_controller.dart';

initAppointment(){
  if(!Get.isRegistered<DoctorAppointmentController>()){
    Get.put<DoctorAppointmentController>(DoctorAppointmentController());
  }
}

disposeAppointment(){
  if(Get.isRegistered<DoctorAppointmentController>()){
    Get.delete<DoctorAppointmentController>();
  }
}