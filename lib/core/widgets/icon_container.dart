import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/manager_height.dart';
import '../resources/manager_width.dart';

Widget iconContainer({required Color? color, required String imagePath}) {
  return Container(
    width: ManagerWidth.w45,
    height: ManagerHeight.h45,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: Padding(
      padding: EdgeInsets.all(
        ManagerWidth.w10,
      ),
      child: SvgPicture.asset(
        imagePath,
      ),
    ),
  );
}
