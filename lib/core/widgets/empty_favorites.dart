import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_button.dart';

import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_styles.dart';

Widget emptyFavorites() {
  var size = MediaQuery.of(Get.context!).size;
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: size.width * ManagerOpacity.op0_7,
          height: size.height * ManagerOpacity.op0_5,
          decoration: BoxDecoration(
              color:
                  ManagerColors.primaryColor.withOpacity(ManagerOpacity.op0_2),
              shape: BoxShape.circle),
        ),
        Text(
          ManagerStrings.thereIsNoFavorites,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s25,
            color: ManagerColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          ManagerStrings.thereIsNoFavorites,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s15,
            color: ManagerColors.blueBell,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.all(ManagerWidth.w30,),
          child: mainButton(
            height: size.height*ManagerOpacity.op0_07,
            onPressed: () {},
            buttonText: ManagerStrings.searchDoctors,
          ),
        )
      ],
    ),
  );
}
