import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_width.dart';

class HomeViewShimmer extends StatelessWidget {
  const HomeViewShimmer({super.key});

  Widget shimmerBox({double? height, double? width, double radius = 12}) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.lightGrey.withOpacity(ManagerOpacity.op0_2),
      highlightColor: ManagerColors.white,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.all(ManagerWidth.w20),
      children: [
        SizedBox(height: size.height * ManagerOpacity.op0_15),

        // Search Bar
        shimmerBox(height: ManagerHeight.h55, width: double.infinity, radius: ManagerRadius.r12),

        SizedBox(height: size.height * ManagerOpacity.op0_07),

        // Title
        shimmerBox(height: 25, width: size.width * 0.5),

        SizedBox(height: size.height * ManagerOpacity.op0_01),

        // Small colored box
        shimmerBox(height: size.height * ManagerOpacity.op0_25, width: size.width * ManagerOpacity.op0_33),

        SizedBox(height: size.height * ManagerOpacity.op0_03),

        // Categories Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return shimmerBox(
              height: size.height * ManagerOpacity.op0_09,
              width: size.width * ManagerOpacity.op0_18,
              radius: ManagerRadius.r20,
            );
          }),
        ),

        SizedBox(height: size.height * ManagerOpacity.op0_03),

        // Popular Doctors Title
        shimmerBox(height: 25, width: size.width * 0.4),

        SizedBox(height: size.height * ManagerOpacity.op0_02),

        // Doctors Horizontal List
        SizedBox(
          height: size.height * ManagerOpacity.op0_4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (_, __) => Padding(
              padding: EdgeInsets.only(right: ManagerWidth.w10),
              child: shimmerBox(
                height: double.infinity,
                width: size.width * 0.6,
                radius: ManagerRadius.r12,
              ),
            ),
          ),
        ),

        SizedBox(height: size.height * ManagerOpacity.op0_07),

        // Featured Doctors Title
        shimmerBox(height: 25, width: size.width * 0.4),

        SizedBox(height: ManagerHeight.h10),

        // Featured Doctors Horizontal List
        SizedBox(
          height: size.height * ManagerOpacity.op0_4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (_, __) => Padding(
              padding: EdgeInsets.only(right: ManagerWidth.w10),
              child: shimmerBox(
                height: double.infinity,
                width: size.width * 0.6,
                radius: ManagerRadius.r12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
