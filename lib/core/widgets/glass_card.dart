import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Light frosted-glass surface shared by the modern Favorites/Chats cards.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
    this.padding = const EdgeInsets.all(14),
    this.borderRadius = 22,
    this.blur = 14,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(borderRadius);

    final Widget glass = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xE6FFFFFF), Color(0xB8EAF7EF)],
            ),
            border: Border.all(color: const Color(0x80FFFFFF), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12154734),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );

    if (onTap == null) {
      return Container(margin: margin, child: glass);
    }

    return Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, borderRadius: radius, child: glass),
      ),
    );
  }
}
