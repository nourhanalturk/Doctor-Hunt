import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/features/out_boarding/presentation/controller/out_boarding_controller.dart';

import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';

class OutBoardingView extends StatelessWidget {
  const OutBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: GetBuilder<OutBoardingController>(
        builder: (controller) {
          return Column(
            children: [
              // Stack(
              //   children: [
              //     Positioned(
              //       left: -104,
              //       top: -20,
              //       child: Container(
              //         width: ManagerWidth.w300,
              //         height: ManagerHeight.h300,
              //         decoration: BoxDecoration(
              //           color: ManagerColors.green,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  children: [
                    ...controller.pages,
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w30,
                ),
                child: mainButton(
                  onPressed: () {
                    controller.onGetStartedPressed();
                  },
                  buttonText: ManagerStrings.getStarted,
                ),
              ),
              SizedBox(
                height: ManagerHeight.h5,
              ),
              TextButton(
                onPressed: () {
                  controller.onSkipPressed();

                },
                child: Text(
                  ManagerStrings.skip,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.blueBell,
                  ),
                ),
              ),
              SizedBox(
                height: ManagerHeight.h10,
              ),
            ],
          );
        },
      ),
    );
  }
}
