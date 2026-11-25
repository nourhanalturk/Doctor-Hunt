import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

class BookingCareHeader extends StatelessWidget {
  const BookingCareHeader({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: Container(
        height: 176,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [
              Color(0xFF9CE0C0),
              Color(0xFFE6F7EE),
            ],
          ),
        ),
        child: Stack(
          children: [
            const HomeHeaderWaves(),
            PositionedDirectional(
              start: 20,
              end: 20,
              top: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🗓️', style: TextStyle(fontSize: 26)),
                  const SizedBox(height: 6),
                  Text(
                    ManagerStrings.myAppointments,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 28,
                      height: 1.15,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF154734),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    ManagerStrings
                        .hereWhereYouCanSeeAllYourBookingAppointments,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularTextStyle(
                      fontSize: 13,
                      color: const Color(0xFF227350),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xB3FFFFFF),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '$count ${ManagerStrings.upcomingAppointments}',
                      style: getMediumTextStyle(
                        fontSize: 12,
                        color: const Color(0xFF154734),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
