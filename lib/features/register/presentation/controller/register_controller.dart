import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/features/register/data/request/add_patient_request.dart';
import 'package:tender/features/register/domain/di/di.dart';
import 'package:tender/features/register/domain/usecase/add_patient_usecase.dart';
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
    if (!isChecked) {
      Get.snackbar(
        'You have to agree the terms ',
        '',
        duration: const Duration(seconds: 4),
      );
    }
    if (formKey.currentState!.validate() && isChecked == true) {
      // register();
      signUp();
    }
  }

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
      (value) async {
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setUserLoggedIn();
        prefs.setPatientName(nameController.text);
        CacheData.setEmail(value: emailController.text);
        CacheData.setUserName(name: nameController.text);
        isLoading = 0;
        update();
        await addPatientAfterSignup(value.user!.id);
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

  addPatientAfterSignup(String userId) async {
    initAddPatientRequest();
    dialogRender(
      context: Get.context!,
      stateRenderType: StateRenderType.popUpLoadingState,
      message: 'loading',
      title: ManagerStrings.sessionFinished,
    );
    AddPatientUseCase useCase = instance<AddPatientUseCase>();
    (await useCase.execute(AddPatientRequest(
            patientId: userId,
            fullName: nameController.text,
            contactNumber: '0599')))
        .fold(
      (l) {
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: l.message,
          title: ManagerStrings.sessionFinished,
        );
      },
      (r) {
        AppSettingsPrefs prefs =instance<AppSettingsPrefs>();
        prefs.setPatientUid(r.patientId);
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpSuccessState,
          message: "success",
          title: ManagerStrings.sessionFinished,
        );

        navigateToMain();
      },
    );
  }

  Future<void> resendVerificationEmail() async {
    await Future.delayed(const Duration(seconds: 60));

    await supabase.auth.signInWithOtp(
      email: emailController.text,
    );
  }

  @override
  void onClose() {
    formKey.currentState!.dispose;
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
