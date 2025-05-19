import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/register/presentation/controller/register_controller.dart';

import '../../../../core/resources/manager_strings.dart';
import '../../../../core/widgets/auth_view.dart';
import '../../../../core/widgets/text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: GetBuilder<RegisterController>(
        builder: (controller) {
          return authView(
            formKey: controller.formKey,
            title: ManagerStrings.joinUsToStartSearching,
            subTitle: ManagerStrings.youCanBookAppointments,
            onGoogleButtonPressed: () {},
            onFacebookButtonPressed: () {},
            isLoading: controller.isLoading,
            obSecure: controller.isObSecure,
            emailController: controller.emailController,
            passwordController: controller.passwordController,
            nameTextField: textField(
              hintText: ManagerStrings.yourName,
              controller: controller.nameController,
              validator: (value) =>
                  controller.validator.validateFullName(value!),
              keyboardType: TextInputType.name,
            ),
            onChangeObSecure: () {
              controller.changeObSecure();
            },
            onMainButtonPressed: () {
              controller.performRegister();
            },
            mainButtonName: ManagerStrings.signUp,
            accountInfoText: ManagerStrings.haveAnAccount,
            accountInfoButton: ManagerStrings.login,
            onAccountInfoButtonPressed: () {
              controller.navigateToLogin();
            },
            checkBoxValue: controller.isChecked,
            onCheckBoxValueChanged: (p0) {
              controller.changeIsCheckBoxValue();
            },
          );
        },
      ),
    );
  }
}
