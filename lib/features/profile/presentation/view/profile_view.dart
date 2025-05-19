import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/core/widgets/profile_textField.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/profile/presentation/controller/profile_controller.dart';
import '../../../../core/cache/app_cache.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ManagerColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return AppScaffold(body: GetBuilder<ProfileController>(
      builder: (controller) {
        return ListView(
          children: [
            Container(
              height: size.height * ManagerOpacity.op0_45,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    ManagerRadius.r25,
                  ),
                  bottomRight: Radius.circular(
                    ManagerRadius.r25,
                  ),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                    top: ManagerHeight.h30,
                    left: ManagerHeight.h30,
                    right: ManagerHeight.h30,
                  ),
                  child: Column(
                    children: [
                      customAppBar(
                        appBarTitle: ManagerStrings.profile,
                        titleColor: ManagerColors.white,
                      ),
                      Text(
                        ManagerStrings.setUpYourProfile,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s19,
                          color: ManagerColors.white,
                        ),
                      ),
                      Text(
                        ManagerStrings.updateYourProfile,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s19,
                          color: ManagerColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CircleAvatar(
                        radius: ManagerRadius.r80,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: size.height * ManagerOpacity.op0_01,
            ),
            Padding(
              padding: EdgeInsets.all(
                ManagerWidth.w20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ManagerStrings.personalInformation,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s19,
                      color: ManagerColors.black,
                    ),
                  ),
                  profileTextField(
                    labelText: ManagerStrings.name,
                    controller: controller.nameController,
                  ),
                  SizedBox(
                    height: size.height * ManagerOpacity.op0_01,
                  ),
                  profileTextField(
                    labelText: ManagerStrings.contactNumber,
                    controller: controller.contactNumberController,
                  ),
                  SizedBox(
                    height: size.height * ManagerOpacity.op0_01,
                  ),
                  profileTextField(
                      labelText: ManagerStrings.dateOfBirth,
                      controller: controller.dateOfBirthController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.selectDate(context);
                        },
                        icon: Icon(
                          ManagerIcons.edit,
                        ),
                      ),
                  ),
                  SizedBox(
                    height: size.height * ManagerOpacity.op0_01,
                  ),
                  profileTextField(
                    labelText: ManagerStrings.location,
                    controller: controller.locationController,
                  ),
                  SizedBox(
                    height: size.height * ManagerOpacity.op0_02,
                  ),
                  mainButton(
                    onPressed: () {},
                    buttonText: ManagerStrings.keepGoing,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ));
  }
}
