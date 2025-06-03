import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_radius.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_font_size.dart';
import '../../../../../core/resources/manager_opacity.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/resources/manager_width.dart';
import '../../../../../core/widgets/main_button.dart';

Widget appointmentDetailsDialog({
  required String doctorName,
  required String contactNumber,
  required dynamic Function()? onPressed,
  String? imagePath,
}) {
  var size = MediaQuery.of(Get.context!).size;
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: ManagerColors.white,
      child: SizedBox(
        height: size.height * ManagerOpacity.op0_5,
        width: size.width * 1.0,
        child: Padding(
          padding: EdgeInsets.all(
            ManagerWidth.w20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width * ManagerOpacity.op0_5,
                height: size.height * ManagerOpacity.op0_2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ManagerColors.primaryColor
                      .withOpacity(ManagerOpacity.op0_2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    ManagerWidth.w10,
                  ),
                  child: imagePath != ''
                      ? CircleAvatar(
                          radius: ManagerRadius.r30,
                          backgroundImage:NetworkImage(imagePath.onNull())
                        )
                      : Center(
                          child: Text(
                            ManagerStrings.noImageAttached,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s19,
                              color: ManagerColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Text(
                '${ManagerStrings.doctorName} is $doctorName',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s30,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              Text(
                '${ManagerStrings.contactNumber} is $contactNumber',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              mainButton(
                onPressed: onPressed,
                buttonText: ManagerStrings.done,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
            ],
          ),
        ),
      ));
}
