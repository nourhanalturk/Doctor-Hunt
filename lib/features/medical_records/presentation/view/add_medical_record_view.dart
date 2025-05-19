import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/medical_records/presentation/controller/medical_records_controller.dart';
import 'package:tender/features/medical_records/presentation/view/widgets/build_type_of_records.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_icon_size.dart';
import '../../../../core/resources/manager_icons.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/widgets/container_spacer.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AddMedicalRecordView extends StatelessWidget {
  const AddMedicalRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<MedicalRecordsController>(
      builder: (controller) {
        return AppScaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  ManagerHeight.h20,
                ),
                child: customAppBar(
                  appBarTitle: ManagerStrings.addARecord,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  ManagerWidth.w20,
                ),
                child: SizedBox(
                  height: size.height * ManagerOpacity.op0_2,

                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (controller.selectedImage != null)
                        Row(
                          children: List.generate(controller.selectedImage!.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width * ManagerOpacity.op0_3,
                                height: size.height * ManagerOpacity.op0_17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    ManagerRadius.r12,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(ManagerRadius.r12),
                                  child: Image.file(
                                    File(controller.selectedImage![index].path),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },),
                        ),
                      SizedBox(
                        width: ManagerWidth.w20,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.onTakePhotoPressed(1);

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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                ManagerIcons.add,
                                color: ManagerColors.primaryColor,
                                size: ManagerIconSize.s50,
                              ),
                              Text(
                                ManagerStrings.addMoreImages,
                                style: getMediumTextStyle(
                                  fontSize: ManagerFontSize.s20,
                                  color: ManagerColors.primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_2,
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
                    padding: EdgeInsets.symmetric(
                      vertical: ManagerHeight.h23,
                      horizontal: ManagerWidth.w40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ManagerStrings.recordFor,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s20,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_01,
                        ),
                        Row(
                          children: [
                            Text(
                              controller.patientName ?? 'Nourhan',
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s22,
                                color: ManagerColors.primaryColor,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              ManagerOpacity.op0_2,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            ManagerWidth.w8,
                                          ),
                                          child: textField(
                                            controller: controller
                                                .patientNameController,
                                            onChanged: (p0) {
                                              controller.changePatientName();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                ManagerIcons.edit,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_02,
                        ),
                        containerSpacer(),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_01,
                        ),
                        Text(
                          ManagerStrings.typeOfRecord,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s20,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_01,
                        ),
                        Row(
                          children: List.generate(
                            controller.recordTypes.length,
                            (index) {
                              var model = controller.recordTypes[index];
                              return typeOfRecords(
                                iconPath: model.icon,
                                title: model.title,
                                onTap: () {
                                  controller.changeSelectedRecordType(index);
                                },
                                selectedIndex: controller.selectedRecordIndex,
                                currentIndex: index ,
                              );
                            },
                          ),
                        ),
                        containerSpacer()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
