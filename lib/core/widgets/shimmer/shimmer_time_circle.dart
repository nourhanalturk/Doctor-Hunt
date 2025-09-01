import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../resources/manager_colors.dart';

class ShimmerTimeCircle extends StatelessWidget {
  const ShimmerTimeCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.primaryColor.withOpacity(0.3),
      highlightColor: ManagerColors.primaryColor.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
