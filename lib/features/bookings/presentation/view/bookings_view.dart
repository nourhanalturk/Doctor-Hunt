import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
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
import '../../../../core/resources/manager_json.dart';
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * ManagerOpacity.op0_02,
                          ),
                          Container(
                            height: size.height * 0.09,
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: size.height * ManagerOpacity.op0_09,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ManagerColors.white,
                                    borderRadius: BorderRadius.circular(
                                      ManagerRadius.r20,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      ManagerWidth.w15,
                                    ),
                                    child: Text(
                                      ManagerStrings
                                          .hereWhereYouCanSeeAllYourBookingAppointments,
                                      style: TextStyle(
                                        fontSize: ManagerFontSize.s15,
                                        color: ManagerColors.black,
                                        fontWeight: ManagerFontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                // Fixed Positioned widget:
                                Positioned(
                                  top: -28,
                                  left: (size.width * 0.7) / 2,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: ManagerColors.scaffoldColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Lottie.asset(
                                      ManagerJson.readMore,
                                      fit: BoxFit.cover,
                                      repeat: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * ManagerOpacity.op0_02,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  controller.userBookingsAppointments.length,
                              itemBuilder: (context, index) {
                                var model =
                                    controller.userBookingsAppointments[index];
                                controller
                                    .convertDateTime(model.appointmentTime);
                                return bookingItem(
                                  date: controller.formattedDate,
                                  time: controller.formattedTime,
                                  patientName: model.dependentName,
                                  onPressed: () async {
                                    final doctorId = controller
                                        .userBookingsAppointments[index]
                                        .doctorId;
                                    await controller.getDoctorName(doctorId);

                                    Get.dialog(
                                      appointmentDetailsDialog(
                                        doctorName: controller.doctorName,
                                        contactNumber:
                                            model.contactNumber.onNull(),
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
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
