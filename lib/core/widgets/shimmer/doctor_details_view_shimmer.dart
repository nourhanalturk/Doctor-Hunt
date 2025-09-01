import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_width.dart';

class DoctorDetailsShimmer extends StatelessWidget {
  const DoctorDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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

    return Padding(
      padding: EdgeInsets.all(ManagerWidth.w15),
      child: ListView(
        children: [
          // AppBar
          shimmerBox(height: ManagerHeight.h20, width: size.width * 0.5),

          SizedBox(height: ManagerHeight.h15,),

          // Doctor Card
          Container(
            width: double.infinity,
            height: size.height * ManagerOpacity.op0_25,
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r12),
            ),
            child: Padding(
              padding: EdgeInsets.all(ManagerWidth.w15),
              child: Row(
                children: [
                  shimmerBox(
                    height: size.height * ManagerOpacity.op0_13,
                    width: size.height * ManagerOpacity.op0_13,
                    radius: ManagerRadius.r12,
                  ),
                  SizedBox(width: ManagerWidth.w15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBox(height: 16, width: size.width * 0.4),
                        SizedBox(height: 8),
                        shimmerBox(height: 14, width: size.width * 0.3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h20),

          // Patient Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
                  (index) => shimmerBox(
                height: size.height * ManagerOpacity.op0_09,
                width: size.width * ManagerOpacity.op0_22,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h20),

          // Services
          shimmerBox(height: 20, width: size.width * 0.3),
          SizedBox(height: ManagerHeight.h10),
          Column(
            children: List.generate(
              3,
                  (index) => Column(
                children: [
                  shimmerBox(height: 16, width: double.infinity),
                  SizedBox(height: ManagerHeight.h10),
                  Container(
                    height: ManagerHeight.h1,
                    width: double.infinity,
                    color: ManagerColors.grayColor.withOpacity(0.2),
                  ),
                  SizedBox(height: ManagerHeight.h10),
                ],
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h20),

          // Last container
          shimmerBox(height: size.height * ManagerOpacity.op0_3),
        ],
      ),
    );
  }
}
