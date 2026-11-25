import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/glass_card.dart';
import 'package:tender/core/widgets/modern_action_button.dart';

Widget successAppointmentDialog({
  required String doctorName,
  required String appointmentDate,
  required String appointmentTime,
  required dynamic Function()? onDonePressed,
  required void Function()? onEditAppointmentPressed,
}) {
  final Size size = MediaQuery.of(Get.context!).size;

  return Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: GlassCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      borderRadius: 28,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width * 0.22,
            height: size.width * 0.22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [Color(0xFF9CE0C0), Color(0xFFE6F7EE)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33168A57),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 44,
              color: Color(0xFF168A57),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            ManagerStrings.thankYou,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF154734),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            ManagerStrings.yourAppointmentSuccessful,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 14,
              color: const Color(0xFF6E7B76),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7F0),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Text(
                  '${ManagerStrings.youBookAnAppointmentWith} $doctorName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF154734),
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 15,
                      color: Color(0xFF168A57),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      appointmentDate,
                      style: TextStyle(
                        fontFamily: ManagerFontFamily.fontFamily,
                        fontSize: 12.5,
                        color: const Color(0xFF227350),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: Color(0xFF168A57),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      appointmentTime,
                      style: TextStyle(
                        fontFamily: ManagerFontFamily.fontFamily,
                        fontSize: 12.5,
                        color: const Color(0xFF227350),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ModernActionButton(
            label: ManagerStrings.done,
            icon: Icons.check_rounded,
            onPressed: onDonePressed,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onEditAppointmentPressed,
            child: Text(
              ManagerStrings.editYourAppointment,
              style: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF168A57),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
