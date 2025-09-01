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

Widget successAppointmentDialog({
  required String doctorName,
  required String appointmentDate,
  required String appointmentTime,
  required dynamic Function()? onDonePressed,
  required void Function()? onEditAppointmentPressed,
}) {
  var size = MediaQuery.of(Get.context!).size;
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: ManagerColors.white,
      child: SizedBox(
        height: size.height * ManagerOpacity.op0_8,
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
                    ManagerWidth.w30,
                  ),
                  child: SvgPicture.asset(
                    ManagerImages.like,
                    height: size.height * ManagerOpacity.op0_1,
                    width: size.width * ManagerOpacity.op0_3,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Text(
                ManagerStrings.thankYou,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s40,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              Text(
                ManagerStrings.yourAppointmentSuccessful,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Text(
                '${ManagerStrings.youBookAnAppointmentWith} '
                '$doctorName ${ManagerStrings.on} '
                ' $appointmentDate \n ${ManagerStrings.at} '
                '$appointmentTime ',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s20,
                  color: ManagerColors.blueBell,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              mainButton(
                onPressed: onDonePressed,
                buttonText: ManagerStrings.done,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              TextButton(
                onPressed: onEditAppointmentPressed,
                child: Text(
                  ManagerStrings.editYourAppointment,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s15,
                    color: ManagerColors.blueBell,
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}
