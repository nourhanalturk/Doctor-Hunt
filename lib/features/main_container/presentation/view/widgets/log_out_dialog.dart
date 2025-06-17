import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_button.dart';

import '../../../../../core/resources/manager_images.dart';

Widget logOutDialog({required void Function()? onOkPressed}) {
  var size = MediaQuery.of(Get.context!).size;
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: ManagerColors.white,
      child: SizedBox(
        height: size.height * ManagerOpacity.op0_18,
        width: size.width * 1.0,
        child: Padding(
            padding: EdgeInsets.all(
              ManagerWidth.w20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ManagerStrings.logOut,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s23,
                    color: ManagerColors.black,
                  ),
                ),
                Text(
                  ManagerStrings.areYouSureToLogOut,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s15,
                    color: ManagerColors.blueBell,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        ManagerStrings.cancel,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s17,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed:onOkPressed,
                      child: Text(
                        ManagerStrings.ok,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s17,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ));
}
