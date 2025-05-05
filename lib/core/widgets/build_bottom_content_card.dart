import 'package:flutter/material.dart';
import '../enums/doctor_card_enum.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_height.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';
import 'main_button.dart';

Widget buildCardContent(
  DoctorCardEnum cardEnum,
  Size size,
  String? costPerHour,
  String? nextTimeAvailable,
  dynamic Function()? onBookNowButtonPressed,
) {
  switch (cardEnum) {
    case DoctorCardEnum.doctorDetailsCard:
      return Column(
        children: [
          mainButton(
            minWidth: ManagerWidth.w100,
            height: ManagerHeight.h40,
            onPressed: onBookNowButtonPressed,
            buttonText: ManagerStrings.bookNow,
            buttonRadius: ManagerRadius.r5,
          )
        ],
      );

    case DoctorCardEnum.appointmentDoctorCard:
      return const SizedBox();

    case DoctorCardEnum.popularDoctorCard:
      return const SizedBox();

    case DoctorCardEnum.doctorSelectTimeCard:
      return const SizedBox();

    case DoctorCardEnum.findDoctorsCard:
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ManagerStrings.nextAvailable,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s18,
                  color: ManagerColors.primaryColor,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: nextTimeAvailable,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s16,
                          color: ManagerColors.blueBell,
                        )),
                    TextSpan(
                      text: ManagerStrings.amTomorrow,
                      style: TextStyle(
                        color: ManagerColors.blueBell,
                        fontSize: ManagerFontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          mainButton(
            minWidth: ManagerWidth.w100,
            height: ManagerHeight.h40,
            onPressed: onBookNowButtonPressed,
            buttonText: ManagerStrings.bookNow,
            buttonRadius: ManagerRadius.r5,
          )
        ],
      );

    default:
      return const SizedBox.shrink();
  }
}
