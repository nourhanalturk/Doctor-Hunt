import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';

import '../../../../config/constants/constants.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<MainHomeController>(
      builder: (controller) {
        return AppScaffold(
          bottomNavigationBar: Container(
            height: size.height * ManagerOpacity.op0_1,
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  ManagerRadius.r25,
                ),
                topRight: Radius.circular(
                  ManagerRadius.r25,
                ),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: Constants.zeroElevation,
              items: controller.items,
              currentIndex: controller.currentBottomNavIndex,
              onTap: (index) {
                controller.changeBottomNavIndex(index);
              },
            ),
          ),
          body: controller.pages[controller.currentBottomNavIndex],
        );
      },
    );
  }
}
