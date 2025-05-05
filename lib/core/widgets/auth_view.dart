import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/validator/validator.dart';
import 'package:tender/core/widgets/text_field.dart';

import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_height.dart';
import '../resources/manager_icons.dart';
import '../resources/manager_images.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';
import 'main_button.dart';

Widget authView(
    {required String title,
    required String subTitle,
    Key? formKey,
    required dynamic Function()? onGoogleButtonPressed,
    required dynamic Function()? onFacebookButtonPressed,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    Widget? nameTextField,
    required bool? obSecure,
    required void Function()? onChangeObSecure,
    required dynamic Function()? onMainButtonPressed,
    required String? mainButtonName,
    void Function()? onForgotPasswordPressed,
    required String accountInfoText,
    required String accountInfoButton,
    required void Function()? onAccountInfoButtonPressed,
    bool? checkBoxValue,
    void Function(bool?)? onCheckBoxValueChanged,
    FocusNode? passwordFocusNode,
      int? isLoading,
    }) {
  FieldValidator validator = FieldValidator();
  var size = MediaQuery.of(Get.context!).size;
  return SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * ManagerOpacity.op0_09,
              ),
              Text(
                title,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s30,
                  color: ManagerColors.black,
                ),
              ),
              Text(
                subTitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.blueBell,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mainButton(
                    onPressed: onGoogleButtonPressed,
                    color: ManagerColors.white,
                    minWidth: ManagerWidth.w160,
                    height: ManagerHeight.h50,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ManagerImages.googleLogo,
                        ),
                        SizedBox(
                          width: ManagerWidth.w4,
                        ),
                        Text(
                          ManagerStrings.google,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.blueBell,
                          ),
                        ),
                      ],
                    ),
                  ),
                  mainButton(
                    onPressed: onFacebookButtonPressed,
                    color: ManagerColors.white,
                    minWidth: ManagerWidth.w160,
                    height: ManagerHeight.h50,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ManagerImages.facebookLogo,
                        ),
                        SizedBox(
                          width: ManagerWidth.w4,
                        ),
                        Text(
                          ManagerStrings.facebook,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.blueBell,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              nameTextField ?? Container(),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              textField(
                hintText: ManagerStrings.email,
                controller: emailController,
                validator: (value) => validator.validateEmail(value!),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              textField(
                hintText: ManagerStrings.password,
                controller: passwordController,
                focusNode: passwordFocusNode,
                validator: (value) => validator.validatePassword(value!),
                keyboardType: TextInputType.visiblePassword,
                obSecure: obSecure,
                suffixIcon: IconButton(
                  onPressed: onChangeObSecure,
                  icon: Icon(
                    obSecure.onNull()
                        ? ManagerIcons.visibility_off
                        : ManagerIcons.visibility,
                  ),
                ),
              ),
              if (mainButtonName == ManagerStrings.signUp)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
                  child: Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue.onNull(),
                        onChanged: onCheckBoxValueChanged,
                        focusColor: ManagerColors.primaryColor,
                        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.green;
                          }
                          return Colors.transparent;
                        }),
                      ),
                      Text(
                        ManagerStrings.iAgreeWithTheTerms,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.blueBell,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_07,
              ),
              mainButton(
                height: ManagerHeight.h60,
                onPressed: isLoading == 1 ? null : onMainButtonPressed,
                buttonText: mainButtonName,
                child: isLoading== 1 ? const CircularProgressIndicator(color: ManagerColors.white): Text(
                  mainButtonName.onNull(),
                  style:
                      getBoldTextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: ManagerColors.white,
                      ),
                ),

              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_01,
              ),
              if (mainButtonName == ManagerStrings.login)
                TextButton(
                  onPressed: onForgotPasswordPressed,
                  child: Text(
                    ManagerStrings.forgotPassword,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s18,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    accountInfoText,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: ManagerWidth.w4,
                  ),
                  TextButton(
                    onPressed: onAccountInfoButtonPressed,
                    child: Text(
                      accountInfoButton,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
