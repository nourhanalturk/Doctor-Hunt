import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/register/data/request/add_patient_request.dart';
import 'package:tender/features/register/data/request/sign_up_request.dart';
import 'package:tender/features/register/domain/model/auth_failure.dart';
import 'package:tender/features/register/domain/usecase/add_patient_usecase.dart';
import 'package:tender/features/register/domain/usecase/is_email_unconfirmed_usecase.dart';
import 'package:tender/features/register/domain/usecase/resend_verification_email_usecase.dart';
import 'package:tender/features/register/domain/usecase/sign_up_usecase.dart';
import '../../../../config/di/di.dart';
import '../../../../core/cache/app_cache.dart';
import '../../../../core/storage/local/app_settings_prefs.dart';
import '../../../../core/validator/validator.dart';
import 'register_ui_constants.dart';

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
        duration: RegisterUiConstants.snackbarDuration,
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

    final result = await instance<SignUpUseCase>().execute(
      SignUpRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    await result.fold(
      (failure) async {
        final authFailure = failure is AuthFailure ? failure : null;
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: authFailure?.dialogMessage ?? failure.message,
          title: '',
        );

        final emailConfirmationResult =
            await instance<IsEmailUnconfirmedUseCase>().execute();
        final isEmailUnconfirmed =
            emailConfirmationResult.fold((_) => true, (value) => value);
        if (isEmailUnconfirmed) {
          resendVerificationEmail();
        }

        Get.snackbar(
          failure.message,
          '',
          duration: RegisterUiConstants.snackbarDuration,
        );
      },
      (signUpResult) async {
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setIsUserLoggedIn(true);
        prefs.setPatientName(nameController.text);
        CacheData.setEmail(value: emailController.text);
        CacheData.setUserName(name: nameController.text);
        isLoading = 0;
        update();
        await addPatientAfterSignup(signUpResult.userId);
      },
    );
  }

  addPatientAfterSignup(String userId) async {
    dialogRender(
      context: Get.context!,
      stateRenderType: StateRenderType.popUpLoadingState,
      message: 'loading',
      title: ManagerStrings.sessionFinished,
    );
    AddPatientUseCase useCase = instance<AddPatientUseCase>();
    (await useCase.execute(
      AddPatientRequest(
        patientId: userId,
        fullName: nameController.text,
        contactNumber: '0599',
      ),
    ))
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
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setPatientUid(r.patientId);
        print(prefs.getPatientUid());
        prefs.setPatientName(nameController.text);
        prefs.setUserImage(imagePath: r.profileImageUrl.onNull());
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
    await Future.delayed(RegisterUiConstants.resendVerificationDelay);

    await instance<ResendVerificationEmailUseCase>()
        .execute(emailController.text);
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
