import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/profile_records_info/presentation/controller/profile_records_info_controller.dart';
import 'package:tender/features/profile_records_info/presentation/view/widgets/record_details_dialog.dart';

import '../../../../core/resources/manager_opacity.dart';

class ProfileRecordsInfoView extends StatelessWidget {
  const ProfileRecordsInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(Get.context!)
        .size;
    return GetBuilder<ProfileRecordsInfoController>(
      builder: (controller) {
        return AppScaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  ManagerHeight.h10,
                ),
                child: customAppBar(
                  appBarTitle: ManagerStrings.profileInfo,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_1,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(
                        ManagerWidth.w25,
                      ),
                      child: Container(
                        height: size.height * ManagerOpacity.op0_6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ManagerColors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            ManagerWidth.w10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ManagerStrings.fullName,
                                style: TextStyle(
                                  fontSize: ManagerFontSize.s20,
                                  color: ManagerColors.black,
                                  fontWeight: ManagerFontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.patientData.fullName.onNull(),
                                style: getRegularTextStyle(
                                  fontSize: ManagerFontSize.s22,
                                  color: ManagerColors.blueBell,
                                ),
                              ),
                              SizedBox(
                                height: size.height * ManagerOpacity.op0_02,
                              ),
                              Text(
                                ManagerStrings.contactNumber,
                                style: TextStyle(
                                  fontSize: ManagerFontSize.s18,
                                  color: ManagerColors.black,
                                  fontWeight: ManagerFontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.patientData.contactNumber.onNull(),
                                style: getRegularTextStyle(
                                  fontSize: ManagerFontSize.s22,
                                  color: ManagerColors.blueBell,
                                ),
                              ),
                              SizedBox(
                                height: size.height * ManagerOpacity.op0_02,
                              ),
                              Text(
                                ManagerStrings.patientRecords,
                                style: TextStyle(
                                  fontSize: ManagerFontSize.s20,
                                  color: ManagerColors.black,
                                  fontWeight: ManagerFontWeight.bold,
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.records.length,
                                    itemBuilder: (context, index) {
                                      var model = controller.records[index];
                                      return InkWell(
                                        onTap: () {
                                          Get.dialog(recordDetailsDialog(
                                              diseaseName: model.diseaseName.onNull(),
                                              description: model.description.onNull(),
                                              doctorName: model.diseaseName.onNull(),
                                              reportDate: model.diseaseName.onNull(),
                                              medicineNames: model.diseaseName.onNull(),
                                              recordFor: model.diseaseName.onNull(),
                                               ));
                                        },
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                size.height *
                                                    ManagerOpacity.op0_1,
                                                width:
                                                size.width *
                                                    ManagerOpacity.op0_8,
                                                decoration: BoxDecoration(
                                                  color: ManagerColors
                                                      .scaffoldColor
                                                      .withOpacity(
                                                      ManagerOpacity.op0_4),
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                    ManagerRadius.r12,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: ManagerRadius.r30,
                                                      backgroundImage:
                                                      model.imageUrls?.length ==
                                                          0
                                                          ? NetworkImage(
                                                        Constants
                                                            .defaultImageUrl,
                                                      )
                                                          : NetworkImage(model
                                                          .imageUrls?[0]
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: ManagerWidth.w15,
                                                    ),
                                                    Text(
                                                      model.diseaseName
                                                          .onNull(),
                                                      style: TextStyle(
                                                        fontSize: ManagerFontSize
                                                            .s20,
                                                        color: ManagerColors
                                                            .black,
                                                        fontWeight:
                                                        ManagerFontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height *
                                                    ManagerOpacity.op0_02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width / 2,
                    child: CircleAvatar(
                      radius: ManagerRadius.r100,
                      backgroundColor: ManagerColors.scaffoldColor,
                      child: CircleAvatar(
                        radius: ManagerRadius.r80,
                        backgroundImage: NetworkImage(
                            controller.patientData.image.onNullImage()),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
