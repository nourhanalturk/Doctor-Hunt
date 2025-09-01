import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_styles.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_opacity.dart';
import '../../../../../core/resources/manager_radius.dart';
import '../../../../../core/resources/manager_width.dart';

Widget medicineItem({required String imagePath, required String title}) {
  var size = MediaQuery.of(Get.context!).size;

  return Container(
    height: size.height * ManagerOpacity.op0_12,
    width: size.width * ManagerOpacity.op0_45,
    decoration: BoxDecoration(
      color: ManagerColors.white,
      borderRadius: BorderRadius.circular(
        ManagerRadius.r12,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(
        ManagerWidth.w10,
      ),
      child: Column(
        children: [
          Container(
            height: size.height * ManagerOpacity.op0_13,
            width: size.width * ManagerOpacity.op0_3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ManagerColors.primaryColor.withOpacity(
                ManagerOpacity.op0_2,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                ManagerWidth.w30,
              ),
              child: SvgPicture.asset(imagePath),
            ),
          ),
          SizedBox(
            height:ManagerHeight.h6,
          ),
          Text(
            title,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.blueBell,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
