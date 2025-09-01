import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';

import '../../../../config/constants/constants.dart';
import '../controller/main_home_controller.dart';
Widget buildBottomNavContainer (MainHomeController controller, Size size){
  return Container(
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
  );
}