import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/enums/doctor_card_enum.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/doctor_details_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/popular_doctor/presentation/controller/popular_doctors_controller.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_icon_size.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/widgets/content_card.dart';

class PopularDoctorsView extends StatelessWidget {
  const PopularDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AppScaffold(body: GetBuilder<PopularDoctorsController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(
            ManagerWidth.w20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(
                onSearchButtonPressed: () {},
                isSearchButtonAppear: true,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Text(
                ManagerStrings.popularDoctors,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s25,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return contentCard(
                      width: size.width * ManagerOpacity.op0_5,
                      doctorNameFontSize: ManagerFontSize.s16,
                      doctorSpecialityFontSize: ManagerFontSize.s14,
                      height: size.height * ManagerOpacity.op0_1,
                      imageHeight: size.height * ManagerOpacity.op0_2,
                      isDebug: true,
                      image: ManagerImages.defaultDoctorImage,
                      doctorName: 'model.name.onNull()',
                      onTap: () {},
                      doctorSpecialty: 'model.specialty',
                      widget: Center(
                        child: RatingBar.readOnly(
                          filledIcon: ManagerIcons.star,
                          emptyIcon: ManagerIcons.outlineStar,
                          initialRating: 5,
                          maxRating: 5,
                          size: ManagerIconSize.s20,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Text(
                ManagerStrings.category,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s25,
                  color: ManagerColors.black,
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      mainDoctorCard(
                        cardHeight: size.height * ManagerOpacity.op0_18 ,
                        doctorRate: 3,
                        isDebug: true,
                        image: ManagerImages.defaultDoctorImage,
                        doctorName: ManagerStrings.name,
                        doctorSpeciality: ManagerStrings.messageViaWhatsapp,
                        onFavoritesPressed: () {},
                        cardEnum: DoctorCardEnum.popularDoctorCard,
                      ),
                      SizedBox(
                        height: size.height * ManagerOpacity.op0_01,
                      ),
                    ],
                  );
                },
              ))
            ],
          ),
        );
      },
    ));
  }
}
