import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';
import 'package:tender/features/main_home/presentation/view/build_bottom_nav_container.dart';
import '../../../../config/constants/constants.dart';
import '../../../main_container/presentation/controller/main_container_controller.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<MainHomeController>(
      builder: (controller) {
        return AppScaffold(
          bottomNavigationBar: controller.currentBottomNavIndex==0 ? GetBuilder<MainContainerController>(
            builder: (mainController) {

              return mainController.isBottomNavShown
                  ? buildBottomNavContainer(controller, size)
                  : const SizedBox();
            },
          ): buildBottomNavContainer(controller, size),
          body: controller.pages[controller.currentBottomNavIndex],
        );
      },
    );
  }
}
