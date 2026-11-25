import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/widgets/glass_card.dart';

class ModernTextField extends StatelessWidget {
  const ModernTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      borderRadius: 18,
      blur: 8,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: ManagerFontFamily.fontFamily,
          fontSize: 14.5,
          color: const Color(0xFF1E2422),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(icon, size: 19, color: const Color(0xFF168A57)),
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: ManagerFontFamily.fontFamily,
            fontSize: 13.5,
            color: const Color(0xFF8A9691),
          ),
        ),
      ),
    );
  }
}
