import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';

Widget bookingEmptyState({required VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 128,
            height: 128,
            child: CustomPaint(
              painter: const _BookingEmptyPainter(),
              child: const Center(
                child: Icon(
                  Icons.calendar_month_outlined,
                  size: 46,
                  color: Color(0xFF168A57),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            ManagerStrings.noAppointmentsYet,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF154734),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ManagerStrings.bookYourFirstAppointment,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 13,
              color: Color(0xFF7E8A86),
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(
              Icons.search_rounded,
              size: 18,
              color: Colors.white,
            ),
            label: Text(
              ManagerStrings.findDoctors,
              style: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF168A57),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            ),
          ),
        ],
      ),
    ),
  );
}

class _BookingEmptyPainter extends CustomPainter {
  const _BookingEmptyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = const Color(0xFFE6F7EE),
    );
    canvas.drawCircle(
      center,
      radius * 0.82,
      Paint()..color = const Color(0xFFDDF5E8),
    );

    final Paint stroke = Paint()
      ..color = const Color(0x66168A57)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.62, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
