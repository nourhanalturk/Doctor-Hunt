import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/main_container/domain/model/menu_item_model.dart';

class MainContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  String name = '';

  int selectedTapIndex = 0;

  bool isBottomNavShown = true;
  String userImage = '';

  changeBottomNavStatus(value) {
    isBottomNavShown = value;
    update();
  }

  List<MenuItemModel> items = [
    MenuItemModel(
      imagePath: ManagerImages.testBooking,
      title: ManagerStrings.myProfile,
      onTap: () {
        Get.toNamed(Routes.profile);
      },
    ),
    MenuItemModel(
      imagePath: ManagerImages.myDoctors,
      title: ManagerStrings.myDoctors,
      onTap: () {
        Get.toNamed(Routes.myDoctors);
      },
    ),
    MenuItemModel(
      imagePath: ManagerImages.medicalRecords,
      title: ManagerStrings.medicalRecords,
      onTap: () {
        Get.toNamed(Routes.medicalRecords);
      },
    ),
    MenuItemModel(
      imagePath: ManagerImages.paymentsIcon,
      title: ManagerStrings.payments,
      onTap: () {},
    ),
    MenuItemModel(
      imagePath: ManagerImages.medicalOrders,
      title: ManagerStrings.medicinesOrders,
      onTap: () {
        Get.toNamed(Routes.medicalOrders);
      },
    ),
    MenuItemModel(
      imagePath: ManagerImages.privacyPolicy,
      title: ManagerStrings.privacyAndPolicy,
      onTap: () {
        Get.toNamed(Routes.privacyAndPolicy);
      },
    ),
    MenuItemModel(
      imagePath: ManagerImages.helpCenter,
      title: ManagerStrings.helpCenter,
      onTap: () {},
    ),
    MenuItemModel(
      imagePath: ManagerImages.setting,
      title: ManagerStrings.settings,
      onTap: () {
        Get.toNamed(Routes.settings);
      },
    ),
  ];

  onSelectedTapChanged(int index) {
    selectedTapIndex = index;
    update();
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        changeBottomNavStatus(false);
      } else if (status == AnimationStatus.reverse) {
        changeBottomNavStatus(true);
      }
    });

    AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
    name = prefs.getPatientName();
    userImage = prefs.getUserImage();
    super.onInit();
  }

  void toggleMenu() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  logOut() async {
    AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
    prefs.setIsUserLoggedIn(false);
    Get.toNamed(Routes.login);
    await Supabase.instance.client.auth.signOut();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
