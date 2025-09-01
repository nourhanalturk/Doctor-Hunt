import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';

Widget customAppBar(
    {void Function()? onSearchButtonPressed,
    bool? isSearchButtonAppear,
    String? appBarTitle,
    Color? titleColor,
      void Function()? onArrowBackTapped
    }) {
  return Row(
    children: [
      Container(
        width: ManagerWidth.w35,
        height: ManagerHeight.h35,
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(
            ManagerRadius.r12,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: ManagerWidth.w4,
          ),
          child: InkWell(
            onTap:onArrowBackTapped?? () {
              Get.back();
            },
            child: Padding(
              padding:  EdgeInsets.all(ManagerWidth.w8,),
              child: SvgPicture.asset(
                ManagerImages.arrowBack,


              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: ManagerWidth.w15,
      ),
      Text(
        appBarTitle.onNull(),
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s22,
          color: titleColor ?? ManagerColors.lightBlack,
        ),
      ),
      const Spacer(),
      isSearchButtonAppear ?? false
          ? IconButton(
              onPressed: onSearchButtonPressed,
              icon: Icon(
                ManagerIcons.search,
                color: ManagerColors.blueBell,
                size: ManagerIconSize.s30,
              ),
            )
          : const SizedBox(),
    ],
  );
}
