import 'package:flutter/cupertino.dart';
import 'package:tender/core/resources/manager_height.dart';

import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';

Widget moreOptions({
  required String title,
  required Widget widget,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ManagerFontSize.s19,
              color: ManagerColors.blueBell,
            ),
          ),
          const Spacer(),
          widget ,

        ],
      ),
      SizedBox(
        height: ManagerHeight.h20,
      ),
    ],
  );
}
