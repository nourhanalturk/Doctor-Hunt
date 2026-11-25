import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';

class ModernChoiceChip extends StatelessWidget {
  const ModernChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.width = 86,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: selected
                  ? const LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [Color(0xFF168A57), Color(0xFF32A577)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xF2FFFFFF), Color(0xE6EAF7EF)],
                    ),
              border: selected
                  ? null
                  : Border.all(color: const Color(0x99FFFFFF)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12154734),
                  blurRadius: 9,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 14,
                    color: selected ? Colors.white : const Color(0xFF168A57),
                  ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: selected ? 12 : 11.5,
                    fontWeight: FontWeight.w700,
                    color:
                        selected ? Colors.white : const Color(0xFF3D4B45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
