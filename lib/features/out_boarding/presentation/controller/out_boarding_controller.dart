import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/out_boarding/presentation/view/widgets/out_boarding_item.dart';

class OutBoardingController extends GetxController {
  PageController pageController = PageController();
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
  List<Widget> pages = [
    OutBoardingItem(
      image: ManagerImages.outBoarding1,
      title: ManagerStrings.findTrustedDoctor,
      subTitle: ManagerStrings.defaultText,
    ),
    OutBoardingItem(
      image: ManagerImages.outBoarding2,
      title: ManagerStrings.chooseBestDoctor,
      subTitle: ManagerStrings.defaultText,
    ),
    OutBoardingItem(
      image: ManagerImages.outBoarding3,
      title: ManagerStrings.easyAppointment,
      subTitle: ManagerStrings.defaultText,
    ),
  ];

  onGetStartedPressed() {
    pageController.nextPage(duration: const Duration(milliseconds: Constants.outBoardingDurationTime,), curve: Curves.bounceInOut);
    if(pageController.page == pages.length-1){
      Get.toNamed(Routes.login);
      prefs.setOutBoardingViewed();
    }
  }

  onSkipPressed() {
    prefs.setOutBoardingViewed();
    Get.toNamed(Routes.login);
  }
}
