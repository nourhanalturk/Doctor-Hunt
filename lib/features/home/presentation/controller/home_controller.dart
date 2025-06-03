import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/home/domain/usecase/home_usecase.dart';
import '../../../../core/enums/section_enum.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../domain/model/categories_model.dart';
import '../../domain/model/home_data_model.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();



  onSearchButtonClearPressed() {
    searchController.text = '';
  }

  List<CategoriesModel> categories = [
    CategoriesModel(
      firstColor: ManagerColors.blue,
      secondColor: ManagerColors.purple,
      icon: ManagerImages.dentalIcon,
      onTap: () {},
    ),
    CategoriesModel(
      firstColor: ManagerColors.primaryColor,
      secondColor: ManagerColors.white,
      icon: ManagerImages.heartIcon,
      onTap: () {},
    ),
    CategoriesModel(
      firstColor: ManagerColors.orange,
      secondColor: ManagerColors.lightOrange,
      icon: ManagerImages.eyeIcon,
      onTap: () {},
    ),
    CategoriesModel(
      firstColor: ManagerColors.darkOrange,
      secondColor: ManagerColors.lightOrange,
      icon: ManagerImages.heartIcon,
      onTap: () {},
    ),
  ];
  List<HomeModel> homeSections = [];
  String errorMessage = '';
  bool isLoading = true ;

  homeRequest() async {
    isLoading = true ;
    update();
    HomeUsecase useCase = instance<HomeUsecase>();
    (await useCase.execute()).fold(
      (l) async {
        isLoading =false ;
        update();
        if (l.message.contains(ManagerStrings.authException) ||
            l.message.contains(ManagerStrings.refreshFailed) ||
            l.message.contains(ManagerStrings.tokenExpired)) {
          dialogRender(
            context: Get.context!,
            stateRenderType: StateRenderType.popUpErrorState,
            message: l.message,
            title: ManagerStrings.sessionFinished,
          );
          await Supabase.instance.client.auth.signOut();
          Get.offAllNamed(Routes.login);
          return;
        }
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: l.message,
          title: '',
        );
        errorMessage = _mapFailureToMessage(l);
        update();
        homeSections.clear();
      },
      (sections) {
        isLoading =false ;
        filterSections(sections);
        update();
      },
    );
  }

  List<HomeModel> popularDoctors = [];
  List<HomeModel> liveDoctors = [];
  List<HomeModel> featuredDoctors = [];

  void filterSections(List<HomeModel> allItems) {
    popularDoctors = allItems
        .where((item) => item.section == SectionType.popular_doctors)
        .toList();
    liveDoctors = allItems
        .where((item) => item.section == SectionType.live_doctors)
        .toList();
    featuredDoctors = allItems
        .where((item) => item.section == SectionType.featured_doctors)
        .toList();
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return '${ManagerStrings.serverError}: ${failure.message}';
    } else if (failure is NetworkAssetBundle) {
      return '${ManagerStrings.networkError}: ${failure.message}';
    } else {
      return '${ManagerStrings.unexpectedError}: ${failure.message}';
    }
  }

  navigateToDoctorDetails(int id) {
    CacheData.setDoctorDetailsId(value: id);
    Get.toNamed(Routes.doctorDetails);
  }


  @override
  void onInit() {
    homeRequest();
    super.onInit();
  }
}
