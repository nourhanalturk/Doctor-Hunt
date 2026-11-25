import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tender/core/widgets/glass_card.dart';

class DoctorDetailsShimmer extends StatelessWidget {
  const DoctorDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5F0EA),
      highlightColor: const Color(0xFFF7FCF9),
      // This shimmer is already a child of the details screen ListView, so it
      // must not create another vertical viewport of its own.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _block(height: 146),
          _block(height: 96),
          _block(height: 188),
          _block(height: 210),
        ],
      ),
    );
  }

  Widget _block({required double height}) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        height: height - 28,
        child: Container(width: double.infinity, color: Colors.white),
      ),
    );
  }
}
