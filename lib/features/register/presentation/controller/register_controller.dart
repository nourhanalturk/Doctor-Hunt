import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/extensions/extensions.dart';

import 'package:tender/features/register/data/request/register_request.dart';
import 'package:tender/features/register/domain/usecase/register_usecase.dart';

import '../../../../config/di/di.dart';
import '../../../../core/cache/app_cache.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/storage/local/app_settings_prefs.dart';
import '../../../../core/validator/validator.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  FieldValidator validator = FieldValidator();
  bool isObSecure = false;
  bool isChecked = false;

  changeIsCheckBoxValue() {
    isChecked = !isChecked;
    update();
  }

  navigateToMain() {
    Get.toNamed(Routes.mainHome);
  }

  performRegister() {
    if(!isChecked){
      Get.snackbar(
        'You have to agree the terms ',
        '',
        duration:
        const Duration(seconds: 4),
      );
    }
    if (formKey.currentState!.validate()&& isChecked==true ) {
      // register();
      signUp();
    }
  }

  // register() async {
  //   RegisterUseCase useCase = instance<RegisterUseCase>();
  //   (await useCase.execute(
  //     RegisterRequest(
  //       email: emailController.text,
  //       password: passwordController.text,
  //       name: nameController.text,
  //     ),
  //   ))
  //       .fold(
  //     (l) {},
  //     (r) {
  //       AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
  //       prefs.setUserLoggedIn();
  //       CacheData.setEmail(value: emailController.text);
  //       CacheData.setUserName(name: nameController.text);
  //       navigateToMain();
  //     },
  //   );
  // }

  navigateToLogin() {
    Get.toNamed(Routes.login);
  }

  changeObSecure() {
    isObSecure = !isObSecure;
    update();
  }

  int isLoading = 0;

  Future<void> signUp() async {
    isLoading = 1;
    update();
    await supabase.auth
        .signUp(password: passwordController.text, email: emailController.text)
        .then(
      (value) {
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setUserLoggedIn();
        CacheData.setEmail(value: emailController.text);
        CacheData.setUserName(name: nameController.text);
        navigateToMain();
        isLoading = 0;
        update();
      },
    ).catchError((error) {
      final errorMessage =
          error is AuthException ? error.message : ManagerStrings.unknown;

      if (supabase.auth.currentUser?.emailConfirmedAt.onNull() == null) {
        resendVerificationEmail();
      }
      Get.snackbar(
        errorMessage,
        '',
        duration:
            const Duration(milliseconds: Constants.sessionFinishedDuration),
      );
    });

  }

  Future<void> resendVerificationEmail() async {
    await supabase.auth.signInWithOtp(
      email: emailController.text,
    );
  }

  @override
  void onClose() {
    formKey.currentState!.dispose;
    super.onClose();
  }
}
