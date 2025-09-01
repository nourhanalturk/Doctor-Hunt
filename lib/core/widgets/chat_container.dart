import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
import 'package:tender/core/resources/manager_height.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';

Widget chatsContainer({
  required String imagePath,
  required String doctorName,
  required void Function()? onTap,
}) {
  var size = MediaQuery.of(Get.context!).size;

  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.all(
        ManagerWidth.w15,
      ),
      child: Column(
        children: [
          Container(
            height: size.height * ManagerOpacity.op0_1,
            width: double.infinity,
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     ManagerColors.primaryColor.withOpacity(
              //       ManagerOpacity.op0_5,
              //     ),
              //     ManagerColors.babyBlue.withOpacity(
              //       ManagerOpacity.op0_2,
              //     ),
              //   ],
              // ),
              borderRadius: BorderRadius.circular(
                ManagerRadius.r12,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                ManagerWidth.w15,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: ManagerRadius.r25,
                    backgroundImage: NetworkImage(
                      imagePath.onNull(),
                    ),
                  ),
                  SizedBox(
                    width: size.width * ManagerOpacity.op0_02,
                  ),
                  Text(
                    doctorName.onNull(),
                    style: TextStyle(
                      fontSize: ManagerFontSize.s20,
                      color: ManagerColors.black,
                      fontWeight: ManagerFontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: ManagerHeight.h1,
            width: double.infinity,
            color: ManagerColors.lightGrey,
          )
        ],
      ),
    ),
  );
}
