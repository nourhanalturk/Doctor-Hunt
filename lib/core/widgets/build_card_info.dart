import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import '../enums/doctor_card_enum.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_height.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';

Widget buildDoctorInfo({
  DoctorCardEnum? cardEnum,
  Size? size,
  String? doctorSpeciality,
  String? costPerHour,
  double? doctorRate,
  String? doctorViewsNumber,
  String? experienceYears,
  String? doctorRatio,
  String? doctorPatientStories,
}) {
  switch (cardEnum) {
    case DoctorCardEnum.doctorDetailsCard:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorSpeciality.onNull(),
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.blueBell,
            ),
          ),
          Row(
            children: [
              RatingBar.readOnly(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: doctorRate.onNull(),
                maxRating: 5,
                size: ManagerIconSize.s20,
              ),
              SizedBox(
                width: size!.width * ManagerOpacity.op0_09,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ManagerStrings.dollarSign,
                      style: TextStyle(
                        color: ManagerColors.primaryColor,
                        fontSize: ManagerFontSize.s18,
                      ),
                    ),
                    TextSpan(
                      text: '$costPerHour${ManagerStrings.byHour}',
                      style: TextStyle(
                        color: ManagerColors.blueBell,
                        fontSize: ManagerFontSize.s18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

    case DoctorCardEnum.appointmentDoctorCard:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorSpeciality.onNull(),
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.blueBell,
            ),
          ),
          Row(
            children: [
              RatingBar.readOnly(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: doctorRate.onNull(),
                maxRating: 5,
                size: ManagerIconSize.s20,
              ),
              SizedBox(
                width: size!.width * ManagerOpacity.op0_09,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ManagerStrings.dollarSign,
                      style: TextStyle(
                        color: ManagerColors.primaryColor,
                        fontSize: ManagerFontSize.s18,
                      ),
                    ),
                    TextSpan(
                      text: '$costPerHour${ManagerStrings.byHour}',
                      style: TextStyle(
                        color: ManagerColors.blueBell,
                        fontSize: ManagerFontSize.s18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

    case DoctorCardEnum.popularDoctorCard:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorSpeciality.onNull(),
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.blueBell,
            ),
          ),
          Row(
            children: [
              RatingBar.readOnly(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: doctorRate.onNull(),
                maxRating: 5,
                size: ManagerIconSize.s20,
              ),
              SizedBox(
                width: size!.width * ManagerOpacity.op0_01,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: doctorRate.onNull().toString(),
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.black,
                      ),
                    ),
                    TextSpan(
                      text: '($doctorViewsNumber${ManagerStrings.views})',
                      style: TextStyle(
                        color: ManagerColors.blueBell,
                        fontSize: ManagerFontSize.s18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

    case DoctorCardEnum.doctorSelectTimeCard:
      return Column(
        children: [
          Text(
            doctorSpeciality.onNull(),
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.blueBell,
            ),
          ),
          RatingBar.readOnly(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            initialRating: doctorRate.onNull(),
            maxRating: 5,
            size: ManagerIconSize.s20,
          ),
        ],
      );

    case DoctorCardEnum.findDoctorsCard:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorSpeciality.onNull(),
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.primaryColor,
            ),
          ),
          Text(
            '$experienceYears ${ManagerStrings.yearsOfExperience}',
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s15,
              color: ManagerColors.blueBell,
            ),
          ),
          Row(
            children: [
              Container(
                height: ManagerHeight.h15,
                width: ManagerWidth.w15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ManagerColors.primaryColor,
                ),
              ),
              SizedBox(
                width: size!.width * ManagerOpacity.op0_01,
              ),
              Text(
                '${doctorRate.onNull()} %',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
              ),
              SizedBox(
                width: size.width * ManagerOpacity.op0_01,
              ),
              Container(
                height: ManagerHeight.h15,
                width: ManagerWidth.w15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ManagerColors.primaryColor,
                ),
              ),
              SizedBox(
                width: size.width * ManagerOpacity.op0_01,
              ),
              Text(
                '${doctorPatientStories.onNull()} ${ManagerStrings.doctorPatientStories}',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.blueBell,
                ),
              ),
            ],
          )
        ],
      );

    default:
      return const SizedBox.shrink();
  }
}
