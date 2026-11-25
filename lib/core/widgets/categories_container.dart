import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import '../resources/manager_radius.dart';

Widget categoriesContainer({
  required Color? firstColor,
  required Color? secondColor,
  required String? icon,
  required Function()? onTap,
  double? height,
  double? width,
  Widget? widget,
}) {
  var size = MediaQuery.of(Get.context!).size;
  final isRtl = Directionality.of(Get.context!) == TextDirection.rtl;
  final tileHeight = height ?? size.height * ManagerOpacity.op0_1;
  final tileWidth = width ?? size.width * ManagerOpacity.op0_2;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: tileHeight,
      width: tileWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            firstColor ?? ManagerColors.primaryColor,
            secondColor ?? ManagerColors.white,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        child: Stack(
          children: [
            Positioned(
              top: -22,
              left: isRtl ? null : -26,
              right: isRtl ? -26 : null,
              child: _decorCircle(82),
            ),
            Positioned(
              bottom: -28,
              left: isRtl ? null : -18,
              right: isRtl ? -18 : null,
              child: _decorCircle(72),
            ),
            Center(
              child: widget ??
                  (icon == null
                      ? const SizedBox.shrink()
                      : SvgPicture.asset(
                          icon,
                          color: ManagerColors.white,
                          width: tileWidth * 0.42,
                          height: tileHeight * 0.42,
                          fit: BoxFit.contain,
                        )),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _decorCircle(double diameter) {
  return Container(
    width: diameter,
    height: diameter,
    decoration: BoxDecoration(
      color: ManagerColors.white.withOpacity(0.12),
      shape: BoxShape.circle,
    ),
  );
}
