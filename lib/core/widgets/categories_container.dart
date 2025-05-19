import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_radius.dart';

Widget categoriesContainer({
  required Color? firstColor,
  required Color? secondColor,
  required String? icon,
  required Function()? onTap,
}) {
  var size = MediaQuery
      .of(Get.context!)
      .size;
  return GestureDetector(
    onTap:onTap,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: size.height * ManagerOpacity.op0_1,
        width: size.width * ManagerOpacity.op0_2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ManagerRadius.r12,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              firstColor!,
              secondColor!,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -5,
              right: -70,
              bottom: 1,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: 5,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Center(
              child:SvgPicture.asset(icon!),
            ),
          ],
        ),
      ),
    ),
  );
}
