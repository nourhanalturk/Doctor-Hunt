import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_height.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_styles.dart';

Widget profileTextField(
    {required String labelText, required TextEditingController controller,Widget? suffixIcon,}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: ManagerColors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      label: Padding(
        padding: EdgeInsets.only(top:ManagerHeight.h30,),
        child: Text(
          labelText,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s17,
            color: ManagerColors.primaryColor,
          ),
        ),
      ),
      suffixIcon:suffixIcon,
      contentPadding: EdgeInsets.only(
        top: ManagerHeight.h24,
        bottom: ManagerHeight.h12,
        left: ManagerHeight.h16,
        right: ManagerHeight.h16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
