import 'package:flutter/material.dart';

const Color _headerWaveLight = Color(0x59FFFFFF);
const Color _headerWaveMint = Color(0x4D85D6B0);
const Color _mediaWaveLight = Color(0x33FFFFFF);
const Color _mediaWaveMint = Color(0x2B6FD3A8);

/// Lightweight organic waves used behind the Home hero header.
class HomeHeaderWaves extends StatelessWidget {
  const HomeHeaderWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _HomeHeaderWavesPainter(),
      child: SizedBox.expand(),
    );
  }
}

class _HomeHeaderWavesPainter extends CustomPainter {
  const _HomeHeaderWavesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Path lightWave = Path()
      ..moveTo(w * 1.02, -12)
      ..cubicTo(w * 0.70, h * 0.06, w * 0.92, h * 0.42, w * 0.46, h * 0.58)
      ..cubicTo(w * 0.12, h * 0.70, w * 0.32, h * 0.96, -24, h * 0.86)
      ..lineTo(-24, -24)
      ..lineTo(w + 24, -24)
      ..close();
    canvas.drawPath(
      lightWave,
      Paint()..color = _headerWaveLight,
    );

    final Path mintWave = Path()
      ..moveTo(w + 20, h * 0.34)
      ..cubicTo(w * 0.78, h * 0.18, w * 0.58, h * 0.68, w * 0.16, h * 0.54)
      ..cubicTo(w * -0.06, h * 0.46, w * 0.10, h * 0.92, -20, h * 1.04)
      ..lineTo(-20, h + 24)
      ..lineTo(w + 24, h + 24)
      ..close();
    canvas.drawPath(
      mintWave,
      Paint()..color = _headerWaveMint,
    );

    final Path softArc = Path()
      ..moveTo(w * 0.58, -20)
      ..cubicTo(w * 0.38, h * 0.18, w * 0.64, h * 0.36, w * 0.30, h * 0.48)
      ..lineTo(w * 0.30, -20)
      ..close();
    canvas.drawPath(
      softArc,
      Paint()..color = const Color(0x33FFFFFF),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Thin ECG pulse drawn without any image asset or package.
class HomePulseIcon extends StatelessWidget {
  const HomePulseIcon({
    super.key,
    this.color = Colors.white,
    this.size = 22,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PulsePainter(color: color),
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  const _PulsePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path()
      ..moveTo(0, h * 0.52)
      ..lineTo(w * 0.20, h * 0.52)
      ..lineTo(w * 0.31, h * 0.22)
      ..lineTo(w * 0.45, h * 0.82)
      ..lineTo(w * 0.58, h * 0.40)
      ..lineTo(w * 0.68, h * 0.52)
      ..lineTo(w, h * 0.52);

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Three small angled green strokes near the search pill.
class HomeSparkles extends StatelessWidget {
  const HomeSparkles({
    super.key,
    this.color = const Color(0xFF168A57),
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 20,
      child: CustomPaint(
        painter: _SparklesPainter(color: color),
      ),
    );
  }
}

class _SparklesPainter extends CustomPainter {
  const _SparklesPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(1, 11), const Offset(7, 5), paint);
    canvas.drawLine(const Offset(10, 16), const Offset(16, 10), paint);
    canvas.drawLine(const Offset(19, 6), const Offset(24, 1), paint);
  }

  @override
  bool shouldRepaint(covariant _SparklesPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Soft mint waves placed behind doctor images inside cards.
class DoctorMediaWaves extends StatelessWidget {
  const DoctorMediaWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _DoctorMediaWavesPainter(),
      child: SizedBox.expand(),
    );
  }
}

class _DoctorMediaWavesPainter extends CustomPainter {
  const _DoctorMediaWavesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Path first = Path()
      ..moveTo(-10, h * 0.34)
      ..cubicTo(w * 0.34, h * 0.10, w * 0.48, h * 0.72, w * 1.10, h * 0.40)
      ..lineTo(w + 20, h + 20)
      ..lineTo(-20, h + 20)
      ..close();
    canvas.drawPath(first, Paint()..color = _mediaWaveLight);

    final Path second = Path()
      ..moveTo(w * 1.08, h * 0.12)
      ..cubicTo(w * 0.72, h * 0.30, w * 0.58, h * -0.08, w * 0.18, h * 0.26)
      ..lineTo(w * 0.18, -20)
      ..lineTo(w + 20, -20)
      ..close();
    canvas.drawPath(second, Paint()..color = _mediaWaveMint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
