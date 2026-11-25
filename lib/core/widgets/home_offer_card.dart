import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_json.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';

class HomeOfferCard extends StatelessWidget {
  const HomeOfferCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
      child: Material(
        color: ManagerColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsetsDirectional.only(
              start: 14,
              end: 14,
              top: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  Color(0xFFE7F8F1),
                  Color(0xFFD4F3E7),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: ManagerColors.primaryColor.withOpacity(0.12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: ManagerColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Lottie.asset(
                    ManagerJson.readMore,
                    fit: BoxFit.cover,
                    repeat: true,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    ManagerStrings.newFullBodyHealthCheckupsAreAvailable,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.lightBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  isRtl
                      ? ManagerIcons.arrowBackIos
                      : ManagerIcons.arrowForwardIos,
                  size: 16,
                  color: ManagerColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
