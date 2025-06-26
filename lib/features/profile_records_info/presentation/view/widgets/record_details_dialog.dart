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

Widget recordDetailsDialog({
  required String diseaseName,
  required String description,
  required String doctorName,
  required  reportDate,
  required String medicineNames,
  required String recordFor,
  String? imagePath,
}) {
  var size = MediaQuery.of(Get.context!).size;
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: ManagerColors.white,
      child: SizedBox(
        height: size.height * ManagerOpacity.op0_7,
        width: size.width * ManagerOpacity.op0_7,
        child: Padding(
          padding: EdgeInsets.all(
            ManagerWidth.w20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${ManagerStrings.diseaseName}  \n $diseaseName',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s30,
                  color: ManagerColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '${ManagerStrings.doctorName}  \n $doctorName',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s30,
                  color: ManagerColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              Text(
                '${ManagerStrings.description} \n $description',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Text(
                '${ManagerStrings.medicineNames} \n $medicineNames',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Text(
                '${ManagerStrings.recordFor} \n $recordFor',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Text(
                '${ManagerStrings.reportDate} \n $reportDate',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
            ],
          ),
        ),
      ));
}
