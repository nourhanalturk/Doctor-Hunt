import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/glass_card.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';
import 'package:tender/core/widgets/modern_action_button.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

class ModernDoctorCard extends StatelessWidget {
  const ModernDoctorCard({
    super.key,
    required this.doctorId,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.priceLabel,
    this.onBookNow,
    this.onChat,
    this.compact = false,
  });

  final int doctorId;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String priceLabel;
  final VoidCallback? onBookNow;
  final VoidCallback? onChat;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double photoSize = compact ? 82 : 96;

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: photoSize,
                  height: photoSize,
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
                          ),
                          child: ClipOval(
                            child: SizedBox(
                              width: photoSize - 20,
                              height: photoSize - 20,
                              child: _doctorImage(imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name.isEmpty ? '—' : name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: ManagerFontFamily.fontFamily,
                              fontSize: compact ? 17 : 19,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF1E2422),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        _favoriteButton(),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F5EB),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        specialty.isEmpty ? '—' : specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF168A57),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _miniBadge(
                          icon: Icons.star_rounded,
                          color: const Color(0xFFF5B942),
                          label: rating.toStringAsFixed(1),
                        ),
                        _miniBadge(
                          icon: Icons.local_hospital_outlined,
                          color: const Color(0xFF168A57),
                          label: priceLabel,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!compact && (onBookNow != null || onChat != null)) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (onChat != null)
                  Expanded(
                    child: ModernActionButton(
                      label: ManagerStrings.chatWithDoctor,
                      icon: Icons.chat_bubble_outline_rounded,
                      filled: false,
                      onPressed: onChat,
                      fontSize: 12.5,
                    ),
                  ),
                if (onChat != null && onBookNow != null)
                  const SizedBox(width: 10),
                if (onBookNow != null)
                  Expanded(
                    child: ModernActionButton(
                      label: ManagerStrings.bookNow,
                      icon: Icons.calendar_month_rounded,
                      onPressed: onBookNow,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _favoriteButton() {
    return GetBuilder<FavoritesController>(builder: (controller) {
      final bool isFavorite = controller.isFavorite(doctorId);

      return InkWell(
        onTap: () async {
          final user = Supabase.instance.client.auth.currentUser;
          if (user == null) {
            Get.snackbar(
              ManagerStrings.tryAgain,
              ManagerStrings.pleaseLoginFirst,
              snackPosition: SnackPosition.TOP,
            );
            return;
          }
          await controller.toggleFavorite(user.id, doctorId);
        },
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x1F154734),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
            size: 18,
            color: isFavorite ? const Color(0xFFF2718C) : const Color(0xFF168A57),
          ),
        ),
      );
    });
  }

  Widget _miniBadge({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xF2FFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x80FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3D4B45),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _doctorImage(String imageUrl) {
  if (imageUrl.isEmpty) {
    return Image.asset(ManagerImages.defaultDoctorImage, fit: BoxFit.cover);
  }
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    cacheWidth: 260,
    errorBuilder: (_, __, ___) =>
        Image.asset(ManagerImages.defaultDoctorImage, fit: BoxFit.cover),
  );
}
