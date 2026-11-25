import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';

import 'package:tender/config/di/di.dart';
import 'package:tender/features/bookings/data/request/get_doctor_request.dart';
import 'package:tender/features/bookings/domain/usecase/get_appointments_usecase.dart';
import 'package:tender/features/bookings/domain/usecase/get_doctor_usecase.dart';
import 'package:tender/features/doctor_appointment/domain/model/appointment_model.dart';

class BookingsController extends GetxController {
  static const String statusPending = 'pending';
  static const String statusDone = 'done';
  static const String statusCancelled = 'cancelled';

  List<AppointmentModel> userBookingsAppointments = [];

  bool isLoading = false;

  getUserAppointments() async {
    isLoading = true;
    update();
    GetAppointmentsUseCase useCase = instance<GetAppointmentsUseCase>();
    (await useCase.execute()).fold(
      (l) {
        isLoading = false;
        update();
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: l.message,
          title: '',
        );
      },
      (r) {
        isLoading = false;
        final now = DateTime.now();
        final startOfToday = DateTime(now.year, now.month, now.day);

        userBookingsAppointments = r.where((appointment) {
          if (appointment.appointmentTime.isBefore(startOfToday)) {
            return false;
          }
          final status = appointment.status.trim().toLowerCase();
          if (status.isEmpty) {
            return true;
          }
          return status != statusDone && status != statusCancelled;
        }).toList()
          ..sort(
            (a, b) => a.appointmentTime.compareTo(b.appointmentTime),
          );

        update();
      },
    );
  }

  String formatDate(DateTime dateTime) =>
      DateFormat('d MMM').format(dateTime);

  String formatTime(DateTime dateTime) =>
      DateFormat('h:mm a').format(dateTime);

  String statusLabel(String status) {
    final normalized = status.trim().toLowerCase();
    if (normalized == statusDone) return 'done';
    if (normalized == statusCancelled) return 'cancelled';
    return 'pending';
  }

  String doctorName = '';

  getDoctorName(int id) async {
    GetDoctorUseCase useCase = instance<GetDoctorUseCase>();
    (await useCase.execute(GetDoctorRequest(doctorId: id))).fold(
      (l) {},
      (doctor) {
        doctorName = doctor.name;
        update();
      },
    );
  }

  @override
  void onInit() {
    getUserAppointments();
    super.onInit();
  }
}
