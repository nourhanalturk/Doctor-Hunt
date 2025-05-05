import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/enums/doctor_card_enum.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/doctor_details_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/doctor_details/presentation/controller/doctor_details_controller.dart';

import '../../../../core/widgets/shimmer/doctor_details_view_shimmer.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsController>(
      builder: (controller) {
        var size = MediaQuery.of(context).size;
        return AppScaffold(
          body: controller.isLoading ?const DoctorDetailsShimmer() : Padding(
            padding: EdgeInsets.only(
              top: ManagerWidth.w15,
              left: ManagerWidth.w15,
              right: ManagerWidth.w10,
              bottom: ManagerWidth.w15,
            ),
            child: ListView(
              children: [
                customAppBar(
                  onSearchButtonPressed: () {},
                  appBarTitle: ManagerStrings.doctorDetails,
                  isSearchButtonAppear: true
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                mainDoctorCard(
                  image: controller.image,
                  doctorName: controller.doctorName,
                  doctorSpeciality: controller.doctorSpeciality,
                  onFavoritesPressed: () {},
                  cardEnum: DoctorCardEnum.doctorDetailsCard,
                  costPerHour: controller.coastPerHour.toString(),
                  doctorRate: controller.rating,
                  onBookNowButtonPressed: () {
                    controller.navigateToAppointment();
                  },
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                Padding(
                  padding: EdgeInsets.all(
                    ManagerWidth.w15,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: size.height * ManagerOpacity.op0_11,
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(
                        ManagerRadius.r12,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            controller.patientStatus.length,
                            (index) => Container(
                              width: size.width * ManagerOpacity.op0_22,
                              height: size.height * ManagerOpacity.op0_09,
                              decoration: BoxDecoration(
                                color: ManagerColors.lightGrey.withOpacity(
                                  ManagerOpacity.op0_1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  ManagerRadius.r12,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.values[index].toString().onNull(),
                                      style: getBoldTextStyle(
                                        fontSize: ManagerFontSize.s20,
                                        color: ManagerColors.black,
                                      ),
                                    ),
                                    Text(
                                      controller.patientStatus[index],
                                      style: getRegularTextStyle(
                                        fontSize: ManagerFontSize.s16,
                                        color: ManagerColors.blueBell,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                Text(
                  ManagerStrings.services,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s22,
                    color: ManagerColors.lightBlack,
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_01,
                ),
                Column(
                  children: List.generate(
                    controller.services.length,
                    (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${index + 1}. ',
                                  style: getBoldTextStyle(
                                    fontSize: ManagerFontSize.s22,
                                    color: ManagerColors.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: controller.services[index],
                                  style: TextStyle(
                                    color: ManagerColors.blueBell,
                                    fontSize: ManagerFontSize.s15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index != controller.services.length - 1)
                            Padding(
                              padding: EdgeInsets.all(ManagerWidth.w15),
                              child: Container(
                                height: ManagerHeight.h1,
                                width: double.infinity,
                                color: ManagerColors.grayColor.withOpacity(0.5),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_03,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * ManagerOpacity.op0_3,
                  decoration: BoxDecoration(
                    color: ManagerColors.white,
                    borderRadius: BorderRadius.circular(
                      ManagerRadius.r12,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
