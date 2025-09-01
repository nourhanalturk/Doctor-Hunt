import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/service/notifications_service.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/home/domain/usecase/home_usecase.dart';
import '../../../../core/enums/section_enum.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../doctor_details/domain/di/di.dart';
import '../../domain/model/categories_model.dart';
import '../../domain/model/home_data_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
  String userName = '';
  String userImage = '';

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
  bool isLoading = true;

  homeRequest() async {
    refreshUserImage();
    isLoading = true;
    update();
    HomeUsecase useCase = instance<HomeUsecase>();
    (await useCase.execute()).fold(
      (l) async {
        isLoading = false;
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
        isLoading = false;
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
  navigateToProfileInfo (){
    Get.toNamed(Routes.profileRecordsInfo);
  }

  navigateToDoctorDetails(int id)async {
    await disposeDoctorDetails();

    CacheData.setDoctorDetailsId(value: id);
    Get.toNamed(Routes.doctorDetails);
  }
  void testNowReminder() async {
    await NotiService().initNotification();

    DateTime now = DateTime.now();
    DateTime scheduledTime = now.add(Duration(minutes: 1));

    print('🕒 Current: $now');
    print('🔔 Scheduled for: $scheduledTime');

    await NotiService().notificationsPlugin.zonedSchedule(
      999,
      '💊 Reminder',
      'You have an appointment test!',
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotiService().notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle, // ✅
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
  refreshUserImage(){
    userImage =  prefs.getUserImage();
    update();
  }




  @override
  void onInit() {
    super.onInit();

    homeRequest();
    userName = prefs.getPatientName() ?? '';
    userImage =  prefs.getUserImage();
  }
}
