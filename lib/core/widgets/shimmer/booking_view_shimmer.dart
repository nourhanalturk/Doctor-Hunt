import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_width.dart';

class BookingsShimmer extends StatelessWidget {
  const BookingsShimmer({super.key});

  Widget shimmerItem(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ManagerHeight.h20,
        horizontal: ManagerWidth.w20,
      ),
      child: Container(
        padding: EdgeInsets.all(ManagerWidth.w15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
        ),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: ManagerColors.lightGrey.withOpacity(ManagerOpacity.op0_3),
              highlightColor: ManagerColors.white,
              child: Container(
                height: size.height * 0.1,
                width: size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(width: ManagerWidth.w15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLine(width: size.width * 0.4, height: 16),
                  SizedBox(height: 10),
                  shimmerLine(width: size.width * 0.25, height: 14),
                  SizedBox(height: 10),
                  shimmerLine(width: size.width * 0.3, height: 14),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget shimmerLine({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.lightGrey.withOpacity(ManagerOpacity.op0_3),
      highlightColor: ManagerColors.white,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // عدد العناصر الوهمية أثناء التحميل
      itemBuilder: (context, index) => shimmerItem(context),
    );
  }
}
