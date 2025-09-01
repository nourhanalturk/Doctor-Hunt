import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';

import 'package:tender/config/di/di.dart';
import 'package:tender/features/bookings/data/request/get_appointment_request.dart';
import 'package:tender/features/bookings/domain/usecase/get_appointments_usecase.dart';
import 'package:tender/features/doctor_appointment/domain/model/appointment_model.dart';

class BookingsController extends GetxController {
  List<AppointmentModel> userBookingsAppointments = [];

  bool isLoading =false;
  getUserAppointments() async {
    isLoading =true ;
    update();
    final userId = supabase.auth.currentUser!.id;
    GetAppointmentsUseCase useCase = instance<GetAppointmentsUseCase>();
    (await useCase.execute(GetAppointmentsRequest(userId: userId))).fold(
      (l) {
        isLoading =false ;
        update();
        dialogRender(
            context: Get.context!,
            stateRenderType: StateRenderType.popUpErrorState,
            message: l.message,
            title: '');
      },
      (r) {
        isLoading =false ;
        update();
        userBookingsAppointments = r;
        print(userBookingsAppointments);

        update();
      },
    );
  }

  String formattedDate = '';

  String formattedTime = '';

  convertDateTime(DateTime dateTime) {
    formattedDate = DateFormat('d MMM').format(dateTime);
    formattedTime = DateFormat('h:mm a').format(dateTime);
  }

  String doctorName = '';

  getDoctorName(int id) async {
    await supabase
        .from(SupabaseTableConstants.homeData)
        .select()
        .eq(SupabaseFieldsConstants.id, id)
        .select(SupabaseFieldsConstants.name)
        .single()
        .then(
      (value) {
        doctorName = value[SupabaseFieldsConstants.name];
        update();
      },
    ).catchError((e) {});
  }

  @override
  void onInit() {
    getUserAppointments();
    super.onInit();
  }
}
