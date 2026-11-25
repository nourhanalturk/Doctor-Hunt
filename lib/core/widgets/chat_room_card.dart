import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/widgets/glass_card.dart';

class ChatRoomCard extends StatelessWidget {
  const ChatRoomCard({
    super.key,
    required this.doctorName,
    required this.imageUrl,
    required this.lastMessage,
    required this.time,
    required this.onTap,
  });

  final String doctorName;
  final String imageUrl;
  final String lastMessage;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return GlassCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xB3FFFFFF), width: 2),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 54,
                    height: 54,
                    child: _chatDoctorImage(imageUrl),
                  ),
                ),
              ),
              PositionedDirectional(
                end: 1,
                bottom: 1,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2ECC7E),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        doctorName.isEmpty ? '—' : doctorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E2422),
                        ),
                      ),
                    ),
                    if (time.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7E8A86),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 12.5,
                    color: const Color(0xFF6E7B76),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isRtl ? Icons.chevron_left : Icons.chevron_right,
            size: 18,
            color: const Color(0xFF168A57),
          ),
        ],
      ),
    );
  }
}

Widget _chatDoctorImage(String imageUrl) {
  if (imageUrl.isEmpty) {
    return Image.asset(ManagerImages.defaultDoctorImage, fit: BoxFit.cover);
  }
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    cacheWidth: 200,
    errorBuilder: (_, __, ___) =>
        Image.asset(ManagerImages.defaultDoctorImage, fit: BoxFit.cover),
  );
}

Widget chatRoomShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color(0xFFE5F0EA),
    highlightColor: const Color(0xFFF7FCF9),
    child: GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: double.infinity, height: 12, color: Colors.white),
                const SizedBox(height: 8),
                Container(width: 150, height: 11, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
