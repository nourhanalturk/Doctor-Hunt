import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_font_size.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/resources/manager_width.dart';

Widget menuItem({
  required String imagePath,
  required String title,
  required void Function()? onTap ,
  required bool isSelected,
}) {
  var size = MediaQuery.of(Get.context!).size;

  return Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(Get.context!).size.width * ManagerOpacity.op0_39,
          bottom: ManagerHeight.h10,
        ),
    child: GestureDetector(
     onTap: onTap,
      child:Container(
          height: size.height * ManagerOpacity.op0_07,
          width: 450,
        color:isSelected ?ManagerColors.white.withOpacity(ManagerOpacity.op0_1):ManagerColors.transparent ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                SvgPicture.asset(
                  imagePath,
                ),
                SizedBox(
                  width: ManagerWidth.w10,
                ),
                Text(
                  title,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s20,
                    color: ManagerColors.white,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  ManagerImages.arrowForward,
                ),
              ],
            ),
          ),
        ),
      ),
      // Container(
      //   height: size.height * ManagerOpacity.op0_07,
      //   width: size.width * ManagerOpacity.op0_2,
      //   // color: isSelected
      //   //     ? ManagerColors.white.withOpacity(0.1)
      //   //     : ManagerColors.transparent,
      //   child: Padding(
      //     padding: EdgeInsets.only(
      //       right: MediaQuery.of(Get.context!).size.width * ManagerOpacity.op0_4,
      //       bottom: ManagerHeight.h30,
      //     ),
      //     child: Row(
      //       children: [
      //         SvgPicture.asset(
      //           imagePath,
      //         ),
      //         SizedBox(
      //           width: ManagerWidth.w10,
      //         ),
      //         Text(
      //           title,
      //           style: getRegularTextStyle(
      //             fontSize: ManagerFontSize.s22,
      //             color: ManagerColors.white,
      //           ),
      //         ),
      //         Spacer(),
      //         SvgPicture.asset(
      //           ManagerImages.arrowForward,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    ),
  );
}
