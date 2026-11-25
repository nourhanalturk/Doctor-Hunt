import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

import '../../features/favorites/presentation/controller/favorites_controller.dart';

Widget contentCard({
  required String image,
  required String doctorName,
  required String? doctorSpecialty,
  required void Function()? onTap,
  double? height,
  double? width,
  double? imageHeight,
  bool? isDebug,
  double? doctorNameFontSize,
  Widget? widget,
  double? doctorSpecialityFontSize,
  String? doctorRate,
  String? coastByHour,
  int? doctorId,
}) {
  final BuildContext context = Get.context!;
  final bool isRtl = Directionality.of(context) == TextDirection.rtl;
  final double cardHeight = height ?? 252;
  final double cardWidth = width ?? 200;
  final double innerHeight = cardHeight - 20;
  final double availableForMedia =
      (innerHeight - 88).clamp(24.0, innerHeight).toDouble();
  final double mediaHeight =
      (imageHeight ?? 145).clamp(0.0, availableForMedia).toDouble();

  return SizedBox(
    height: cardHeight,
    width: cardWidth,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: const Color(0x0A000000),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: mediaHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Container(
                        color: const Color(0xFFDFF4E9),
                        child: const DoctorMediaWaves(),
                      ),
                      Positioned.fill(
                        child: isDebug ?? false
                            ? Image.asset(
                                image,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (_, __, ___) =>
                                    const _DoctorFallback(),
                              )
                            : Image.network(
                                image,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                cacheWidth: 600,
                                errorBuilder: (_, __, ___) =>
                                    const _DoctorFallback(),
                              ),
                      ),
                      if (doctorId != null)
                        Positioned(
                          top: 8,
                          left: isRtl ? null : 8,
                          right: isRtl ? 8 : null,
                          child: _FavoriteButton(doctorId: doctorId),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: isRtl
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: cardWidth - 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          doctorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: ManagerFontFamily.fontFamily,
                            fontSize: doctorNameFontSize ?? 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E2422),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctorSpecialty ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: ManagerFontFamily.fontFamily,
                            fontSize: doctorSpecialityFontSize ?? 12.5,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7E8A86),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (doctorRate != null && doctorRate.isNotEmpty)
                              _RatingChip(rate: doctorRate),
                            const Spacer(),
                            if (coastByHour != null && coastByHour.isNotEmpty)
                              Text(
                                '\$$coastByHour/h',
                                style: TextStyle(
                                  fontFamily: ManagerFontFamily.fontFamily,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF168A57),
                                ),
                              ),
                          ],
                        ),
                        if (widget != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: widget,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _DoctorFallback extends StatelessWidget {
  const _DoctorFallback();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ManagerImages.defaultDoctorImage,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip({required this.rate});

  final String rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFDDF5E8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            ManagerIcons.star,
            size: 12,
            color: const Color(0xFFF5B400),
          ),
          const SizedBox(width: 4),
          Text(
            rate,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E2422),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.doctorId});

  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      builder: (controller) {
        final bool isFav = controller.isFavorite(doctorId);
        return InkWell(
          onTap: () async {
            final user = Supabase.instance.client.auth.currentUser;
            if (user == null) {
              Get.snackbar('Error', 'Please login first');
              return;
            }
            controller.toggleFavorite(user.id, doctorId);
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: const Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isFav ? ManagerIcons.favoriteFilled : ManagerIcons.favorite,
              size: 16,
              color: isFav ? const Color(0xFFE92E30) : const Color(0xFF5C6964),
            ),
          ),
        );
      },
    );
  }
}
