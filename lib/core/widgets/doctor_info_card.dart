import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_font_weight.dart';
import '../resources/manager_height.dart';
import '../resources/manager_icons.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';

Widget doctorInfoCard({
  required void Function()? onFavoritePressed,
  required String? doctorRate,
  required String? doctorName,
  required String? coastByHour,
  required String? image,
}) {
  var size = MediaQuery.of(Get.context!).size;

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: ManagerWidth.w5,
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: size.height * ManagerOpacity.op0_2,
        width: size.width * ManagerOpacity.op0_33,
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(
            ManagerRadius.r12,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: ManagerWidth.w8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onFavoritePressed,
                    icon: Icon(
                      ManagerIcons.favorite,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    ManagerIcons.star,
                    color: ManagerColors.yellow,
                  ),
                  Text(
                    doctorRate.onNull(),
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.lightBlack,
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: ManagerRadius.r30,
                backgroundImage: NetworkImage(image.onNull()),
              ),
            ),
            Center(
              child: Text(doctorName.onNull(),
                  style: TextStyle(
                    fontSize: ManagerFontSize.s18,
                    color: ManagerColors.lightBlack,
                    fontWeight: ManagerFontWeight.bold,
                  )),
            ),
            SizedBox(
              height: ManagerHeight.h1,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ManagerStrings.dollarSign,
                      style: TextStyle(
                        color: ManagerColors.primaryColor,
                        fontSize: ManagerFontSize.s12,
                      ),
                    ),
                    TextSpan(
                      text: '$coastByHour ${ManagerStrings.byHour}',
                      style: TextStyle(
                        color: ManagerColors.blueBell,
                        fontSize: ManagerFontSize.s12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
