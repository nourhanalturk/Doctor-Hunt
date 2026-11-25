import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_styles.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.actionLabel = 'See All',
    this.topPadding = 24,
    this.titleFontSize = 18,
    this.actionFontSize = 13,
    this.actionIconSize = 14,
  });

  final String title;
  final String actionLabel;
  final double topPadding;
  final double titleFontSize;
  final double actionFontSize;
  final double actionIconSize;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 20,
        end: 20,
        top: topPadding,
        bottom: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getBoldTextStyle(
                fontSize: titleFontSize,
                color: const Color(0xFF1E2422),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            actionLabel,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: actionFontSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF168A57),
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            isRtl ? ManagerIcons.arrowBackIos : ManagerIcons.arrowForwardIos,
            size: actionIconSize,
            color: const Color(0xFF168A57),
          ),
        ],
      ),
    );
  }
}
