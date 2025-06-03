import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/bookings/presentation/controller/bookings_controller.dart';
import 'package:tender/features/bookings/presentation/view/widget/appointment_details_dialog.dart';
import 'package:tender/features/bookings/presentation/view/widget/booking_item.dart';

import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/shimmer/booking_view_shimmer.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<BookingsController>(
      builder: (controller) {
        return AppScaffold(
          body: controller.isLoading
              ? const BookingsShimmer()
              : controller.userBookingsAppointments.isEmpty
                  ? EmptyStateWidget(
                      appBarTitle: ManagerStrings.favoriteDoctors,
                      title: ManagerStrings.thereIsNoFavorites,
                      subtitle: ManagerStrings.searchDoctors,
                      buttonText: ManagerStrings.searchDoctors,
                      onPressed: () {},
                      svgAssetPath: ManagerImages.cartIcon,
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        top: ManagerWidth.w20,
                        left: ManagerWidth.w20,
                        bottom: ManagerWidth.w1,
                        right: ManagerWidth.w20,
                      ),
                      child: ListView.builder(
                        itemCount: controller.userBookingsAppointments.length,
                        itemBuilder: (context, index) {
                          var model =
                              controller.userBookingsAppointments[index];
                          controller.convertDateTime(model.appointmentTime);
                          return bookingItem(
                            date: controller.formattedDate,
                            time: controller.formattedTime,
                            patientName: model.dependentName,
                            onPressed: () {
                              Get.dialog(
                                appointmentDetailsDialog(
                                  doctorName: '',
                                  contactNumber: model.contactNumber.onNull(),
                                  imagePath: model.dependentImageUrl,
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
