import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/privacy_and_policy/presentation/controller/privacy_and_policy_controller.dart';

class PrivacyAndPolicyView extends StatelessWidget {
  const PrivacyAndPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyAndPolicyController>(
      builder: (controller) {
        var size = MediaQuery.of(context).size;

        return AppScaffold(
          body: Padding(
            padding: EdgeInsets.all(
              ManagerWidth.w15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customAppBar(
                  appBarTitle: ManagerStrings.privacyAndPolicy,
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_05,
                ),
                Text(
                  ManagerStrings.doctorHuntAppsPrivacyAndPolicy,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s20,
                    color: ManagerColors.blueBell,
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                Text(
                  ManagerStrings.defaultText,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s15,
                    color: ManagerColors.blueBell,
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
