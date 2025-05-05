import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import '../enums/doctor_card_enum.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_icons.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';
import 'build_bottom_content_card.dart';
import 'build_card_info.dart';

Widget mainDoctorCard({
  double? cardWidth,
  double? cardHeight,
  required String image,
  required String doctorName,
  required String doctorSpeciality,
  required void Function()? onFavoritesPressed,
  double? imageHeight,
  String? costPerHour,
  required DoctorCardEnum cardEnum,
  String? nextTimeAvailable,
  dynamic Function()? onBookNowButtonPressed,
  double? doctorRate,
  String? doctorViewsNumber,
  String? experienceYears,
  String? doctorRatio,
  String? doctorPatientStories,
  bool? isDebug,
}) {
  var size = MediaQuery.of(Get.context!).size;

  return Container(
    width: cardWidth ?? double.infinity,
    height: cardHeight ?? size.height * ManagerOpacity.op0_25,
    decoration: BoxDecoration(
      color: ManagerColors.white,
      borderRadius: BorderRadius.circular(
        ManagerRadius.r12,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        left: ManagerWidth.w15,
        right: ManagerWidth.w15,
        top: ManagerWidth.w15,
        bottom: ManagerWidth.w5,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  ManagerRadius.r12,
                ),
                child: isDebug?? false ?  Image.asset(
                  image,
                  height: imageHeight ?? size.height * ManagerOpacity.op0_13,
                ): Image.network(
                  image,
                  height: imageHeight ?? size.height * ManagerOpacity.op0_13,
                ),
              ),
              SizedBox(
                width: ManagerWidth.w15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        doctorName.onNull(),
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s22,
                          color: ManagerColors.black,
                        ),
                      ),
                      SizedBox(
                        width: size.width * ManagerOpacity.op0_03,
                      ),
                      IconButton(
                        onPressed: onFavoritesPressed,
                        icon: Icon(
                          ManagerIcons.favorite,
                          color: ManagerColors.blueBell,
                        ),
                      ),
                    ],
                  ),
                  buildDoctorInfo(
                    cardEnum: cardEnum,
                    doctorSpeciality: doctorSpeciality,
                    costPerHour: costPerHour,
                    size: size,
                    doctorRate: doctorRate.onNull(),
                    doctorRatio: doctorRatio.onNull(),
                    doctorViewsNumber: doctorViewsNumber.onNull(),
                    experienceYears: experienceYears.onNull(),
                    doctorPatientStories: doctorPatientStories.onNull(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height * ManagerOpacity.op0_02,
          ),
          buildCardContent(
            cardEnum,
            size,
            costPerHour,
            nextTimeAvailable,
            onBookNowButtonPressed,
          ),
        ],
      ),
    ),
  );
}
