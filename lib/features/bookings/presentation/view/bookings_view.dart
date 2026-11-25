import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/booking_appointment_card.dart';
import 'package:tender/core/widgets/booking_care_header.dart';
import 'package:tender/core/widgets/booking_empty_state.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/bookings/presentation/controller/bookings_controller.dart';
import 'package:tender/features/bookings/presentation/view/widget/appointment_details_dialog.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingsController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () => controller.getUserAppointments(),
          child: AppScaffold(
            body: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                BookingCareHeader(
                  count: controller.userBookingsAppointments.length,
                ),
                const SizedBox(height: 34),
                if (controller.isLoading &&
                    controller.userBookingsAppointments.isEmpty)
                  const SizedBox(
                    height: 260,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF168A57),
                      ),
                    ),
                  ),
                if (!controller.isLoading &&
                    controller.userBookingsAppointments.isEmpty)
                  bookingEmptyState(
                    onPressed: () =>
                        Get.find<MainHomeController>().changeBottomNavIndex(0),
                  ),
                if (!controller.isLoading &&
                    controller.userBookingsAppointments.isNotEmpty)
                  ...[
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        bottom: 14,
                      ),
                      child: Text(
                        ManagerStrings.upcomingAppointments,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2422),
                        ),
                      ),
                    ),
                    ...controller.userBookingsAppointments.map(
                      (model) => bookingAppointmentCard(
                        patientName: model.dependentName ?? '',
                        imageUrl: model.dependentImageUrl,
                        date: controller.formatDate(model.appointmentTime),
                        time: controller.formatTime(model.appointmentTime),
                        statusLabel: ManagerStrings.appointmentPending,
                        onDetails: () async {
                          await controller.getDoctorName(model.doctorId);
                          Get.dialog(
                            appointmentDetailsDialog(
                              doctorName: controller.doctorName,
                              contactNumber: model.contactNumber ?? '',
                              imagePath: model.dependentImageUrl,
                              onPressed: () => Get.back(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
              ],
            ),
          ),
        );
      },
    );
  }
}
