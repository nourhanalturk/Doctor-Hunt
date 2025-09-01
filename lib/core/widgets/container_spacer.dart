import 'package:flutter/material.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_height.dart';
import '../resources/manager_radius.dart';

Widget containerSpacer(){
  return  Container(
    width: double.infinity,
    height: ManagerHeight.h1,
    decoration: BoxDecoration(
      color: ManagerColors.lightGrey,
      borderRadius: BorderRadius.circular(
        ManagerRadius.r12,
      ),
    ),
  );
}