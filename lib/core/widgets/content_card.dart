import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_height.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';
import '../extensions/extensions.dart';

Widget contentCard({
  required String image,
  required String doctorName,
  required String? doctorSpecialty,
  required void Function()? onTap,
  double? height,
  double? width,
  double? imageHeight,
  bool? isDebug,
  double? doctorNameFontSize,
  Widget? widget ,
  double? doctorSpecialityFontSize


}) {
  Size size = MediaQuery.of(Get.context!).size;
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(
        top: ManagerHeight.h20,
        left: ManagerWidth.w10,
      ),
      child: Container(
        height: height ?? size.height * ManagerOpacity.op0_2,
        width: width ?? size.width * ManagerOpacity.op0_6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ManagerRadius.r12,
          ),
          color: ManagerColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  ManagerRadius.r12,
                ),
                topRight: Radius.circular(
                  ManagerRadius.r12,
                ),
              ),
              child: isDebug??false ? Image.asset(
                image,
                height: imageHeight ?? size.height * 0.27,
                width: double.infinity,
                fit: BoxFit.cover,
              ) : Image.network(
                image,
                height: imageHeight ?? size.height * 0.27,
                width: double.infinity,
                fit: BoxFit.cover,
              ) ,
            ),
            SizedBox(
              height: ManagerHeight.h15,
            ),
            Center(
              child: Text(doctorName.onNull(),
                  style: TextStyle(
                    fontSize: doctorNameFontSize??ManagerFontSize.s20,
                    color: ManagerColors.lightBlack,
                    fontWeight: ManagerFontWeight.bold,
                  )),
            ),
            SizedBox(
              height: ManagerHeight.h1,
            ),
            Center(
              child: Text(
                doctorSpecialty.onNull(),
                style: getMediumTextStyle(
                  fontSize:doctorSpecialityFontSize ?? ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
            ),
            Center(child: widget?? const SizedBox()),
          ],
        ),
      ),
    ),
  );

}
