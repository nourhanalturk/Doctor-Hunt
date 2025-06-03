import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';

import '../../../../../core/resources/manager_width.dart';

Widget bookingItem({ required String date , required time ,required patientName,required void Function()? onPressed}) {
  var size = MediaQuery.of(Get.context!).size;

  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Container(
      width: double.infinity,
      height: size.height * ManagerOpacity.op0_18,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(
          ManagerRadius.r6,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          ManagerWidth.w15,
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: size.width * ManagerOpacity.op0_2,
                  height: size.height * ManagerOpacity.op0_1,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor,
                    borderRadius: BorderRadius.circular(
                      ManagerRadius.r12,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      date,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s17,
                        color: ManagerColors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ManagerHeight.h5,
                ),
                Container(
                  width: size.width * ManagerOpacity.op0_2,
                  height: size.height * ManagerOpacity.op0_03,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(
                      ManagerOpacity.op0_3,
                    ),
                    borderRadius: BorderRadius.circular(
                      ManagerRadius.r4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s17,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * ManagerOpacity.op0_01,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ManagerStrings.appointmentBookedByYou,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s17,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    '${ManagerStrings.appointmentFor} $patientName',
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: onPressed, icon: Icon(Icons.more_horiz_rounded)),

          ],
        ),
      ),
    ),
  );
}
