import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_icons.dart';
import '../resources/manager_opacity.dart';
import 'icon_container.dart';

Widget settingsItem({
  required Color? color,
  required String imagePath,
  required String title,
  required void Function()? onPressed,
}) {
  var size = MediaQuery.of(Get.context!).size;

  return Row(
    children: [
      iconContainer(
        color: color,
        imagePath: imagePath,
      ),
      SizedBox(
        width: size.width * ManagerOpacity.op0_02,
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: ManagerFontSize.s19,
          color: ManagerColors.blueBell,
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          ManagerIcons.arrowForwardIos,
          color: ManagerColors.blueBell,
        ),
      ),
    ],
  );
}
