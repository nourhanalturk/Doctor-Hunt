import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/my_doctors/domain/model/my_doctors_model.dart';
import 'package:tender/features/my_doctors/domain/usecase/get_my_doctors_details_usecase.dart';
import 'package:tender/features/my_doctors/domain/usecase/get_my_doctors_usecase.dart';

class MyDoctorsController extends GetxController {
  List doctorIds = [];

  getMyDoctors() async {
    GetMyDoctorsUseCase useCase = instance<GetMyDoctorsUseCase>();
    (await useCase.execute()).fold(
      (l) {
        dialogRender(
            context: Get.context!,
            stateRenderType: StateRenderType.popUpErrorState,
            message: ManagerStrings.cacheError,
            title: '');
      },
      (r) {
        doctorIds = r;
        getDoctorDetails();
      },
    );
  }

  int isLoading = 0;
  List<MyDoctorsModel> data = [];

  getDoctorDetails() async {
    isLoading = 1;
    update();
    GetMyDoctorsDetailsUseCase useCase =
        instance<GetMyDoctorsDetailsUseCase>();
    (await useCase.execute(List<int>.from(doctorIds))).fold(
      (l) {
        isLoading = 0;
        update();
      },
      (r) {
        data = r;
        isLoading = 0;
        update();
      },
    );
  }

  @override
  void onInit() {
    getMyDoctors();
    super.onInit();
  }
}
