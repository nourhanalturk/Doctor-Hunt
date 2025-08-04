import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/auth_view.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';
import 'package:tender/features/login/presentation/view/widgets/forgot_password.dart';
import 'package:tender/features/login/presentation/view/widgets/otp_bottom_sheet.dart';
import 'package:tender/features/login/presentation/view/widgets/reset_password_bottom_sheet.dart';

import '../../../../core/resources/manager_opacity.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      body: GetBuilder<LoginController>(
        init: LoginController(),
        autoRemove: true,
        builder: (controller) {
          var size = MediaQuery.of(context).size;
          return authView(
            formKey: controller.formKey,
            title: ManagerStrings.welcomeBack,
            subTitle: ManagerStrings.youCanBookAppointments,
            onGoogleButtonPressed: () {},
            onFacebookButtonPressed: () {},
            emailController: controller.emailController,
            passwordController: controller.passwordController,
            passwordFocusNode: controller.passwordFocusNode,
            obSecure: controller.passwordVisibility[ManagerStrings.password]!,
            onChangeObSecure: () {
              controller.changeObSecure(ManagerStrings.password);
            },
            onMainButtonPressed: () {
              controller.performLogin();
            },
            isLoading: controller.isLoading,
            onForgotPasswordPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: size.height * ManagerOpacity.op0_5,
                              child: PageView(
                                controller: controller.pageController,
                                children: [
                                  forgotPassword(
                                    controller: controller,
                                  ),
                                  otpBottomSheet(
                                    controller: controller,
                                  ),
                                  resetPasswordBottomSheet(
                                    controller: controller,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            mainButtonName: ManagerStrings.login,
            accountInfoText: ManagerStrings.doNotHaveAnAccount,
            accountInfoButton: ManagerStrings.joinUs,
            onAccountInfoButtonPressed: () {
              controller.navigateToRegister();
            },
          );
        },
      ),
    );
  }
}
