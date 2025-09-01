import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_styles.dart';

Widget typeOfRecords({
  required String iconPath,
  required String title,
  required void Function()? onTap,
  required int selectedIndex,
  required int currentIndex,
}) {
  bool isSelected = selectedIndex == currentIndex;
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        SvgPicture.asset(
          iconPath,
          color: isSelected ? ManagerColors.blueBell : ManagerColors.blueBell,
        ),
        Text(
          title,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s17,
            color: isSelected ? ManagerColors.blueBell : ManagerColors.blueBell,
          ),
        ),
      ],
    ),
  );
}
