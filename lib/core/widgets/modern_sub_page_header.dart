import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

/// Mint page header used by details/appointment screens.
class ModernSubPageHeader extends StatelessWidget {
  const ModernSubPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
    this.trailing,
    this.height = 148,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final Widget? trailing;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: Container(
        height: height,
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
              start: 16,
              top: 14,
              child: InkWell(
                onTap: onBack,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0x99FFFFFF),
                    border: Border.all(color: const Color(0xD9FFFFFF)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F154734),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF154734),
                  ),
                ),
              ),
            ),
            if (trailing != null)
              PositionedDirectional(end: 16, top: 14, child: trailing!),
            PositionedDirectional(
              start: 22,
              end: 22,
              top: 68,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 24,
                      height: 1.15,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF154734),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 13,
                      color: const Color(0xFF227350),
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
