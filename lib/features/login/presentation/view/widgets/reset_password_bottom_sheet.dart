import 'package:flutter/material.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/validator/validator.dart';
import 'package:tender/core/widgets/main_bottom_sheet.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';

import '../../../../../core/resources/manager_icons.dart';

Widget resetPasswordBottomSheet({
  required LoginController controller,
}) {
  FieldValidator validator = FieldValidator();
  return mainBottomSheet(
    title: ManagerStrings.resetPassword,
    subTitle: ManagerStrings.setTheNewPasswordForYourAccount,
    widgets: Column(
      children: [
        textField(
          controller: controller.resetPasswordController,
          hintText: ManagerStrings.resetPassword,
          focusNode: controller.resetPasswordFocusNode,
          validator: (value) => validator.validatePassword(value!),
          keyboardType: TextInputType.visiblePassword,
          obSecure: controller.passwordVisibility[ManagerStrings.resetPassword],
          suffixIcon: IconButton(
            onPressed: () {
              controller.changeObSecure(ManagerStrings.resetPassword);
            },
            icon: Icon(
              controller.passwordVisibility[ManagerStrings.resetPassword]!
                  ? ManagerIcons.visibility_off
                  : ManagerIcons.visibility,
            ),
          ),
        ),
        SizedBox(
          height: ManagerHeight.h5,
        ),
        textField(
          controller: controller.confirmResetPasswordController,
          hintText: ManagerStrings.confirmPassword,
          focusNode: controller.confirmPasswordFocusNode,
          validator: (value) => validator.validatePassword(value!),
          keyboardType: TextInputType.visiblePassword,
          obSecure: controller.passwordVisibility[ManagerStrings.confirmPassword],
          suffixIcon: IconButton(
            onPressed: () {
              controller.changeObSecure(ManagerStrings.confirmPassword);
            },
            icon: Icon(
              controller.passwordVisibility[ManagerStrings.confirmPassword]!
                  ? ManagerIcons.visibility_off
                  : ManagerIcons.visibility,
            ),
          ),
        ),
      ],
    ),
    onPressed: () {

      controller.navigateToNextPage();
    },
    buttonText: ManagerStrings.updatePassword,
  );
}
