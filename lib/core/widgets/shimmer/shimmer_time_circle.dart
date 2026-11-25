import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTimeCircle extends StatelessWidget {
  const ShimmerTimeCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5F0EA),
      highlightColor: const Color(0xFFF7FCF9),
      child: Container(
        width: 88,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
