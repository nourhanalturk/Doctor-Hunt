import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/bookings/presentation/controller/bookings_controller.dart';
import 'package:tender/features/bookings/presentation/view/widget/appointment_details_dialog.dart';
import 'package:tender/features/bookings/presentation/view/widget/booking_item.dart';

import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_json.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/shimmer/booking_view_shimmer.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingsController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const BookingsShimmer();
        }

        if (controller.userBookingsAppointments.isEmpty) {
          return Scaffold(
            backgroundColor: ManagerColors.scaffoldColor,
            body: Center(
              child: EmptyStateWidget(
                appBarTitle: ManagerStrings.myAppointments,
                title: ManagerStrings.noAppointmentsYet,
                subtitle: ManagerStrings.bookYourFirstAppointment,
                buttonText: ManagerStrings.findDoctors,
                onPressed: () {
                },
                svgAssetPath: ManagerImages.imageIcon,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: ManagerColors.scaffoldColor,
          body: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ManagerColors.primaryColor.withOpacity(0.9),
                      ManagerColors.lightBlueGray,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Lottie.asset(
                        ManagerJson.readMore,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            ManagerStrings.myAppointments,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s24,
                              color: ManagerColors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            ManagerStrings.hereWhereYouCanSeeAllYourBookingAppointments,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s16,
                              color: ManagerColors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ManagerStrings.upcomingAppointments,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s18,
                          color: ManagerColors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.userBookingsAppointments.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final model = controller.userBookingsAppointments[index];
                            controller.convertDateTime(model.appointmentTime);

                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: model.dependentImageUrl != null
                                                ? DecorationImage(
                                              image: NetworkImage(
                                                model.dependentImageUrl.onNullImage(),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                                : null,
                                            color: ManagerColors.lightGrey,
                                          ),
                                          child: model.dependentImageUrl == null
                                              ? const Icon(Icons.person, size: 30)
                                              : null,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.dependentName.onNull(),
                                                style: getBoldTextStyle(
                                                  fontSize: ManagerFontSize.s16,
                                                  color: ManagerColors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${controller.formattedDate} • ${controller.formattedTime}',
                                                style: getRegularTextStyle(
                                                  fontSize: ManagerFontSize.s14,
                                                  color: ManagerColors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () async {
                                          final doctorId = model.doctorId;
                                          await controller.getDoctorName(doctorId);
                                          Get.dialog(
                                            appointmentDetailsDialog(
                                              doctorName: controller.doctorName,
                                              contactNumber: model.contactNumber.onNull(),
                                              imagePath: model.dependentImageUrl,
                                              onPressed: () => Get.back(),
                                            ),
                                          );
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: ManagerColors.primaryColor.withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(ManagerRadius.r12),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                        ),
                                        child: Text(
                                          ManagerStrings.viewDetails,
                                          style: getMediumTextStyle(
                                            fontSize: ManagerFontSize.s14,
                                            color: ManagerColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}