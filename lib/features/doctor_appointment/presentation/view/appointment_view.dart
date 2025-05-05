import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/doctor_appointment/presentation/controller/doctor_appointment_controller.dart';

import '../../../../core/enums/doctor_card_enum.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/widgets/doctor_details_card.dart';

class DoctorAppointmentView extends StatelessWidget {
  const DoctorAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return AppScaffold(body: GetBuilder<DoctorAppointmentController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(
            ManagerWidth.w15,
          ),
          child: ListView(
            children: [
              customAppBar(
                onSearchButtonPressed: () {},
                appBarTitle: ManagerStrings.appointment,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              mainDoctorCard(
                cardHeight: size.height * ManagerOpacity.op0_18,
                image: ManagerImages.defaultDoctorImage,
                doctorName: ManagerStrings.name,
                doctorSpeciality: ManagerStrings.sessionFinished,
                onFavoritesPressed: () {},
                cardEnum: DoctorCardEnum.appointmentDoctorCard,
                costPerHour: ManagerStrings.threeHundred,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Text(
                ManagerStrings.appointmentFor,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s20,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              textField(
                controller: controller.patientName,
                hintText: ManagerStrings.patientName,
                hintColor: ManagerColors.blueBell,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              textField(
                controller: controller.contactNumber,
                hintText: ManagerStrings.contactNumber,
                hintColor: ManagerColors.blueBell,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Text(
                ManagerStrings.whoIsPatient,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s20,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    width: size.width * ManagerOpacity.op0_3,
                    height: size.height * ManagerOpacity.op0_17,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor.withOpacity(
                          ManagerOpacity.op0_2),
                      borderRadius: BorderRadius.circular(
                        ManagerRadius.r12,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          ManagerIcons.add, color: ManagerColors.primaryColor,
                          size: ManagerIconSize.s50,),
                        Text(ManagerStrings.add, style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s20,
                            color: ManagerColors.primaryColor),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              mainButton(onPressed: () {
                controller.onNextPressed();

              }, buttonText: ManagerStrings.next)
            ],
          ),
        );
      },
    ),);
  }
}
