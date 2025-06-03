import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/icon_container.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/more_options_item.dart';
import 'package:tender/core/widgets/settings_item.dart';
import 'package:tender/features/settings/presentation/controller/settings_controller.dart';

import '../../../../core/resources/manager_colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(body: GetBuilder<SettingsController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(
            ManagerHeight.h14,
          ),
          child: ListView(
            children: [
              customAppBar(
                appBarTitle: ManagerStrings.settings,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              Text(
                ManagerStrings.accountSettings,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ManagerColors.blueBell,
                  fontSize: ManagerFontSize.s20,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              settingsItem(
                color: ManagerColors.redColor,
                imagePath: ManagerImages.lockIcon,
                title: ManagerStrings.changePassword,
                onPressed: () {},
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              settingsItem(
                color: ManagerColors.green,
                imagePath: ManagerImages.timerNotificationIcon,
                title: ManagerStrings.notifications,
                onPressed: () {},
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              settingsItem(
                color: ManagerColors.babyBlue,
                imagePath: ManagerImages.statisticsIcon,
                title: ManagerStrings.statistics,
                onPressed: () {},
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_02,
              ),
              settingsItem(
                color: ManagerColors.orange,
                imagePath: ManagerImages.aboutUsIcon,
                title: ManagerStrings.aboutUs,
                onPressed: () {},
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              Text(
                ManagerStrings.moreOptions,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ManagerColors.blueBell,
                  fontSize: ManagerFontSize.s20,
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              moreOptions(
                title: ManagerStrings.textMessages,
                widget: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: ManagerColors.white,
                  activeTrackColor: ManagerColors.primaryColor,
                ),
              ),
              moreOptions(
                title: ManagerStrings.phoneCalls,
                widget: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: ManagerColors.white,
                  activeTrackColor: ManagerColors.primaryColor,
                ),
              ),
              moreOptions(
                title: ManagerStrings.languages,
                widget: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        controller.language,
                        style: TextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.blueBell,
                        ),
                      ),
                      Icon(
                        ManagerIcons.arrowForwardIos,
                        color: ManagerColors.blueBell,
                        size: ManagerIconSize.s20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              moreOptions(
                title: ManagerStrings.currency,
                widget: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        '${ManagerStrings.dollarSign}${ManagerStrings.sUsd}',
                        style: TextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.blueBell,
                        ),
                      ),
                      Icon(
                        ManagerIcons.arrowForwardIos,
                        color: ManagerColors.blueBell,
                        size: ManagerIconSize.s20,
                      )
                    ],
                  ),
                ),
              ),
              moreOptions(
                title: ManagerStrings.linkedAccounts,
                widget: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        '${ManagerStrings.facebook},${ManagerStrings.google}',
                        style: TextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.blueBell,
                        ),
                      ),
                      Icon(
                        ManagerIcons.arrowForwardIos,
                        color: ManagerColors.blueBell,
                        size: ManagerIconSize.s20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
