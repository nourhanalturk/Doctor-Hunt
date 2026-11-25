import 'package:flutter/material.dart';

/// Soft mint/blue bubbles behind the conversation, drawn without any asset.
class ChatBackground extends StatelessWidget {
  const ChatBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _ChatBackgroundPainter(),
      child: SizedBox.expand(),
    );
  }
}

class _ChatBackgroundPainter extends CustomPainter {
  const _ChatBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    canvas.drawCircle(
      Offset(w * 0.10, h * 0.12),
      w * 0.34,
      Paint()..color = const Color(0x1A9CE0C0),
    );
    canvas.drawCircle(
      Offset(w * 0.94, h * 0.38),
      w * 0.28,
      Paint()..color = const Color(0x1433A975),
    );
    canvas.drawCircle(
      Offset(w * 0.18, h * 0.86),
      w * 0.30,
      Paint()..color = const Color(0x145CE0D0),
    );

    final Paint stroke = Paint()
      ..color = const Color(0x0F168A57)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(Offset(w * 0.78, h * 0.72), w * 0.16, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
