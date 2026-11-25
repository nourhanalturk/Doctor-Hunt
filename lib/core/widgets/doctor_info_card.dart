import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

import '../../features/favorites/presentation/controller/favorites_controller.dart';

Widget doctorInfoCard({
  required void Function()? onFavoritePressed,
  required String? doctorRate,
  required String? doctorName,
  required String? coastByHour,
  required String? image,
  required void Function()? onTap,
  int? doctorId,
  String? doctorSpeciality,
  double? cardHeight,
  double? cardWidth,
  bool? isFavInfoShown,
  double? imageRadius,
}) {
  final BuildContext context = Get.context!;
  final bool isRtl = Directionality.of(context) == TextDirection.rtl;
  final double height = cardHeight ?? 190;
  final double preferredWidth = cardWidth ?? 170;
  final double mediaHeight = (height * 0.58).clamp(96.0, 112.0);
  final double mediaRadius = imageRadius ?? 14;
  final bool showPrice = !(isFavInfoShown ?? false);

  return LayoutBuilder(
    builder: (context, constraints) {
      final double maxWidth = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : preferredWidth;
      final double width =
          preferredWidth > maxWidth ? maxWidth : preferredWidth;

      return SizedBox(
        height: height,
        width: width,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                      borderRadius: BorderRadius.circular(mediaRadius),
                      child: Stack(
                        children: [
                          Container(
                            color: const Color(0xFFDFF4E9),
                            child: const DoctorMediaWaves(),
                          ),
                          Positioned.fill(
                            child: (image ?? '').isEmpty
                                ? const _DoctorFallback()
                                : Image.network(
                                    image!,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    cacheWidth: 320,
                                    errorBuilder: (_, __, ___) =>
                                        const _DoctorFallback(),
                                  ),
                          ),
                          if ((doctorRate ?? '').isNotEmpty)
                            Positioned(
                              top: 8,
                              left: isRtl ? null : 8,
                              right: isRtl ? 8 : null,
                              child: _RatingPill(rate: doctorRate!),
                            ),
                          Positioned(
                            top: 8,
                            left: isRtl ? 8 : null,
                            right: isRtl ? null : 8,
                            child: doctorId == null
                                ? const _StaticFavoriteButton()
                                : _FavoriteButton(doctorId: doctorId),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    doctorName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E2422),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          doctorSpeciality ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: ManagerFontFamily.fontFamily,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7E8A86),
                          ),
                        ),
                      ),
                      if (showPrice &&
                          (coastByHour ?? '').isNotEmpty &&
                          coastByHour != '0.0')
                        const SizedBox(width: 6),
                      if (showPrice &&
                          (coastByHour ?? '').isNotEmpty &&
                          coastByHour != '0.0')
                        Text(
                          '\$$coastByHour/h',
                          style: TextStyle(
                            fontFamily: ManagerFontFamily.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF168A57),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
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

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.rate});

  final String rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xD9B0E8CB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            ManagerIcons.star,
            size: 11,
            color: const Color(0xFF168A57),
          ),
          const SizedBox(width: 3),
          Text(
            rate,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF154734),
            ),
          ),
        ],
      ),
    );
  }
}

class _StaticFavoriteButton extends StatelessWidget {
  const _StaticFavoriteButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        ManagerIcons.favorite,
        size: 14,
        color: const Color(0xFF5C6964),
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
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFav ? ManagerIcons.favoriteFilled : ManagerIcons.favorite,
              size: 14,
              color: isFav ? const Color(0xFFE92E30) : const Color(0xFF5C6964),
            ),
          ),
        );
      },
    );
  }
}
