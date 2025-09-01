import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/my_doctors/domain/model/my_doctors_model.dart';

class MyDoctorsController extends GetxController {
  List doctorIds = [];

  getMyDoctors() async {
    final patientId = supabase.auth.currentUser!.id;
    await supabase
        .from(SupabaseTableConstants.appointments)
        .select(SupabaseFieldsConstants.doctorId)
        .eq(SupabaseFieldsConstants.patientId, patientId)
        .then(
      (value) {
        doctorIds = value
            .map(
              (e) => e[SupabaseFieldsConstants.doctorId],
            )
            .toSet()
            .toList();
        getDoctorDetails();
      },
    ).catchError((e) {
      dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: ManagerStrings.cacheError,
          title: '');
    });
  }

  int isLoading = 0;
  List<MyDoctorsModel> data = [];

  getDoctorDetails() async {
    isLoading = 1;
    update();
    await supabase
        .from(SupabaseTableConstants.homeData)
        .select(
            '${SupabaseFieldsConstants.name}, ${SupabaseFieldsConstants.image}')
        .inFilter(SupabaseFieldsConstants.id, doctorIds)
        .then(
      (value) {
        data = value
            .map(
              (e) => MyDoctorsModel.fromJson(e),
            )
            .toList();
        isLoading = 0;
        update();
      },
    ).catchError((e) {
      isLoading = 0;
      update();
    });
  }

  @override
  void onInit() {
    getMyDoctors();
    super.onInit();
  }
}
