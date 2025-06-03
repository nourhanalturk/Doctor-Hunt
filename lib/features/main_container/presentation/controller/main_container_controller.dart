import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  changeBottomNavStatus(value){
    isBottomNavShown =value;
    update();
  }

  List<MenuItemModel> items = [
    MenuItemModel(
      imagePath: ManagerImages.myDoctors,
      title: ManagerStrings.myDoctors,
      onTap: () {},
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
      imagePath: ManagerImages.testBooking,
      title: ManagerStrings.testBookings,
      onTap: () {},
    ),
    MenuItemModel(
      imagePath: ManagerImages.privacyPolicy,
      title: ManagerStrings.privacyAndPolicy,
      onTap: () {},
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
    name = 'ramo'; //prefs.getPatientName();
    super.onInit();
  }

  void toggleMenu() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  void onClose() {
    animationController.dispose();

    super.onClose();
  }
}
