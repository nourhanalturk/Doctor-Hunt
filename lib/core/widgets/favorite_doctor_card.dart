import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/widgets/glass_card.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

Widget favoriteDoctorCard({
  required String name,
  required String specialty,
  required String imageUrl,
}) {
  return GlassCard(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: 94,
            child: Stack(
              children: [
                const DoctorMediaWaves(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xB3FFFFFF),
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26154734),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        width: 72,
                        height: 72,
                        child: _favoriteDoctorImage(imageUrl),
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 4,
                  end: 4,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1F000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 15,
                      color: Color(0xFFF2718C),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: ManagerFontFamily.fontFamily,
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E2422),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F5EB),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            specialty.isEmpty ? '—' : specialty,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF168A57),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _favoriteDoctorImage(String imageUrl) {
  if (imageUrl.isEmpty) {
    return Image.asset(ManagerImages.defaultDoctorImage, fit: BoxFit.cover);
  }
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    cacheWidth: 240,
    errorBuilder: (_, __, ___) =>
        Image.asset(ManagerImages.defaultDoctorImage, fit: BoxFit.cover),
  );
}

Widget favoriteDoctorShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color(0xFFE5F0EA),
    highlightColor: const Color(0xFFF7FCF9),
    child: GlassCard(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 94,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 12, color: Colors.white),
          const SizedBox(height: 8),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    ),
  );
}
