import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/features/doctor_appointment/presentation/view/widget/success_appointment_dialog.dart';

class DoctorAppointmentController extends GetxController {
  TextEditingController patientName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();

  onNextPressed() {
    Get.dialog(
      successAppointmentDialog(
        doctorName: CacheData.getDoctorDetailsId().onNull().toString(),
        appointmentDate: 'friday 23',
        appointmentTime: '3:00',
        onDonePressed: () {

        },
        onEditAppointmentPressed: () {

        },
      ),
    );
  }
}
