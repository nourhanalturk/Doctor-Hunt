import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/main_bottom_sheet.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';

Widget forgotPassword({required LoginController controller}) {
  return mainBottomSheet(
    title: ManagerStrings.forgotPassword,
    subTitle: ManagerStrings.enterYourEmailForTheVerificationProcess,
    widgets: textField(
      controller: controller.forgotPasswordEmailController,
      hintText: ManagerStrings.email,
    ),
    onPressed: () {
      controller.sendOtpToUser(controller.forgotPasswordEmailController.text, '1234');
      controller.navigateToNextPage();
    },
    buttonText: ManagerStrings.keepGoing,
  );
}
