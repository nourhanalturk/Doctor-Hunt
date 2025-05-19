import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tender/core/resources/manager_height.dart';
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
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/widgets/doctor_details_card.dart';

class DoctorAppointmentView extends StatelessWidget {
  const DoctorAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      body: GetBuilder<DoctorAppointmentController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w15,
                  vertical: ManagerWidth.w10,
                ),
                child: customAppBar(
                  onSearchButtonPressed: () {},
                  appBarTitle: ManagerStrings.appointment,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        ManagerWidth.w15,
                      ),
                      child: ListView(
                        children: [
                          mainDoctorCard(
                            cardHeight: size.height * ManagerOpacity.op0_18,
                            image: controller.doctorImage,
                            doctorName: controller.doctorName,
                            doctorSpeciality: controller.doctorSpeciality,
                            onFavoritesPressed: () {},
                            cardEnum: DoctorCardEnum.appointmentDoctorCard,
                            costPerHour:
                                controller.doctorCoastPerHour.toString(),
                            doctorRate: controller.doctorRating,
                            doctorId: controller.doctorId,
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
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    width: size.width * ManagerOpacity.op0_3,
                                    height: size.height * ManagerOpacity.op0_17,
                                    decoration: BoxDecoration(
                                      color: ManagerColors.primaryColor
                                          .withOpacity(ManagerOpacity.op0_2),
                                      borderRadius: BorderRadius.circular(
                                        ManagerRadius.r12,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          ManagerIcons.add,
                                          color: ManagerColors.primaryColor,
                                          size: ManagerIconSize.s50,
                                        ),
                                        Text(
                                          ManagerStrings.add,
                                          style: getMediumTextStyle(
                                              fontSize: ManagerFontSize.s20,
                                              color:
                                                  ManagerColors.primaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ManagerWidth.w10,
                              ),
                              if (controller.selectedImage != null)
                                SizedBox(
                                  width: size.width * ManagerOpacity.op0_3,
                                  height: size.height * ManagerOpacity.op0_15,
                                  child: Image.file(
                                    File(controller.selectedImage!.path),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * ManagerOpacity.op0_02,
                          ),
                          mainButton(
                              onPressed: () {
                                controller.onNextPressed();
                              },
                              buttonText: ManagerStrings.next)
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: controller.focusedDay,
                            selectedDayPredicate: (day) {
                              return isSameDay(controller.selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              controller.onFocusDayChanged(
                                  selectedDay, focusedDay);
                            },
                            enabledDayPredicate: (day) {
                              return !day.isBefore(
                                DateTime.now().subtract(
                                  Duration(
                                    hours: DateTime.now().hour,
                                    minutes: DateTime.now().minute,
                                    seconds: DateTime.now().second,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ManagerColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  ManagerRadius.r50,
                                ),
                                topRight: Radius.circular(
                                  ManagerRadius.r50,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: ManagerHeight.h20,
                                left:  ManagerWidth.w30,
                                right: ManagerWidth.w30,

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ManagerStrings.availableTime,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s18,
                                      color: ManagerColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * ManagerOpacity.op0_01,
                                  ),
                                  controller.availableTimes.isEmpty
                                      ? Center(
                                          child: Text(
                                            ManagerStrings
                                                .noAvailableTimeForTheDoctorToday,
                                            style: getBoldTextStyle(
                                              fontSize: ManagerFontSize.s20,
                                              color: ManagerColors.primaryColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : SizedBox(
                                          height: size.height *
                                              ManagerOpacity.op0_12,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller
                                                .availableTimes.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                    width: ManagerWidth.w10),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  controller.appointmentTime =
                                                      controller
                                                              .rawAvailableTimes[
                                                          index];
                                                  controller
                                                      .onSelectTime(index);
                                                },
                                                child: Container(
                                                  height: size.height *
                                                      ManagerOpacity.op0_1,
                                                  width: size.width *
                                                      ManagerOpacity.op0_2,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: controller
                                                                .appointmentTimeSelectedIndex ==
                                                            index
                                                        ? ManagerColors
                                                            .primaryColor
                                                        : ManagerColors
                                                            .primaryColor
                                                            .withOpacity(
                                                            ManagerOpacity
                                                                .op0_1,
                                                          ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller.availableTimes[
                                                          index],
                                                      style: getMediumTextStyle(
                                                        fontSize:
                                                            ManagerFontSize.s14,
                                                        color: controller
                                                                    .appointmentTimeSelectedIndex ==
                                                                index
                                                            ? ManagerColors
                                                                .white
                                                            : ManagerColors
                                                                .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                  Text(
                                    ManagerStrings.reminderMeBefore,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s18,
                                      color: ManagerColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * ManagerOpacity.op0_13,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.reminderTimes.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: ManagerWidth.w10,
                                      ),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            controller
                                                .onReminderTimesPressed(index);
                                          },
                                          child: Container(
                                            height: size.height *
                                                ManagerOpacity.op0_1,
                                            width: size.width *
                                                ManagerOpacity.op0_2,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: controller
                                                          .reminderTimeIndex ==
                                                      index
                                                  ? ManagerColors.primaryColor
                                                  : ManagerColors.primaryColor
                                                      .withOpacity(
                                                      ManagerOpacity.op0_1,
                                                    ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${controller.reminderTimes[index]}\n${ManagerStrings.minit}',
                                                style: getMediumTextStyle(
                                                  fontSize: ManagerFontSize.s14,
                                                  color: controller
                                                              .reminderTimeIndex ==
                                                          index
                                                      ? ManagerColors.white
                                                      : ManagerColors
                                                          .primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * ManagerOpacity.op0_01,
                                  ),
                                  mainButton(
                                    onPressed: () {
                                      controller.addAppointment();
                                    },
                                    buttonText: ManagerStrings.confirm,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
