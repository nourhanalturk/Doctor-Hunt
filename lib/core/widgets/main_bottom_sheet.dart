import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';
import 'main_button.dart';

Widget mainBottomSheet({
  required String title,
  required String subTitle,
  required Widget widgets,
  required dynamic Function()? onPressed,
  required String? buttonText,
}) {
  var size = MediaQuery.of(Get.context!).size;
  return Padding(
    padding: EdgeInsets.all(
      ManagerWidth.w20,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getBoldTextStyle(
              fontSize: ManagerFontSize.s23, color: ManagerColors.black),
        ),
        SizedBox(
          height: size.height * ManagerOpacity.op0_01,
        ),
        Text(
          subTitle,
          style: getRegularTextStyle(
              fontSize: ManagerFontSize.s16, color: ManagerColors.blueBell),
        ),
        SizedBox(
          height: size.height * ManagerOpacity.op0_03,
        ),
        widgets,
        SizedBox(
          height: size.height * ManagerOpacity.op0_03,
        ),
        mainButton(
          onPressed: onPressed,
          buttonText: buttonText,
        ),
      ],
    ),
  );
}
