import 'package:get/get.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';

class SplashController extends GetxController {
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();

  @override
  void onInit() {
    Future.delayed(
      const Duration(
        seconds: Constants.splashTimeSecond,
      ),
      () {
        if (prefs.getUserLoggedIn()) {
          Get.toNamed(Routes.mainHome);
        } else {
          if (prefs.getOutBoardingViewed()) {
            Get.toNamed(Routes.login);
          } else {
            Get.toNamed(Routes.outBoarding);
          }
        }
      },
    );
    super.onInit();
  }
}
