import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

/// Mint hero header with the same visual language as Home and Bookings.
class ModernCareHeader extends StatelessWidget {
  const ModernCareHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.countLabel,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String countLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: Container(
        height: 190,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [Color(0xFF9CE0C0), Color(0xFFE6F7EE)],
          ),
        ),
        child: Stack(
          children: [
            const HomeHeaderWaves(),
            PositionedDirectional(
              start: 20,
              end: 20,
              top: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0x99FFFFFF),
                      border: Border.all(color: const Color(0xD9FFFFFF)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F154734),
                          blurRadius: 12,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 23, color: const Color(0xFF168A57)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 28,
                      height: 1.15,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF154734),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularTextStyle(
                      fontSize: 13,
                      color: const Color(0xFF227350),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xB3FFFFFF),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      countLabel,
                      style: TextStyle(
                        fontFamily: ManagerFontFamily.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF154734),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
