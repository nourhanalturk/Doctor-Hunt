import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';

class ModernActionButton extends StatelessWidget {
  const ModernActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    this.enabled = true,
    this.expanded = true,
    this.height = 50,
    this.fontSize = 14,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;
  final bool enabled;
  final bool expanded;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? action = enabled ? onPressed : null;

    return SizedBox(
      width: expanded ? double.infinity : null,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: filled && enabled
                  ? const LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [Color(0xFF168A57), Color(0xFF32A577)],
                    )
                  : null,
              color: filled
                  ? (enabled ? null : const Color(0xFFB9C9C1))
                  : const Color(0xB3FFFFFF),
              border: filled
                  ? null
                  : Border.all(color: const Color(0xFF9CE0C0), width: 1.3),
              boxShadow: filled && enabled
                  ? const [
                      BoxShadow(
                        color: Color(0x33168A57),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ]
                  : const [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              children: [
                // Flexible keeps long labels (e.g. "Chat with doctor") from
                // overflowing when two buttons share one row.
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                      color: filled ? Colors.white : const Color(0xFF168A57),
                    ),
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 6),
                  Icon(
                    icon,
                    size: 16,
                    color: filled ? Colors.white : const Color(0xFF168A57),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
