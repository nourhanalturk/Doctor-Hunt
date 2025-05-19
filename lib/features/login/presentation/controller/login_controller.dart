import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/core/validator/validator.dart';
import 'package:tender/features/login/data/request/login_request.dart';
import 'package:tender/features/login/domain/usecase/login_usecase.dart';
import '../../../../config/constants/constants.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/service/email_service.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController confirmResetPasswordController =
      TextEditingController();

  var formKey = GlobalKey<FormState>();
  FieldValidator validator = FieldValidator();

  PageController pageController = PageController();

  String otp = '';

  var passwordVisibility = {
    ManagerStrings.password: false,
    ManagerStrings.resetPassword: false,
    ManagerStrings.confirmPassword: false,
  };
  FocusNode passwordFocusNode = FocusNode();
  FocusNode resetPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  changeObSecure(String field) {
    if (field == ManagerStrings.password) {
      passwordFocusNode.unfocus();
    } else if (field == ManagerStrings.resetPassword) {
      resetPasswordFocusNode.unfocus();
    } else if (field == ManagerStrings.confirmPassword) {
      confirmPasswordFocusNode.unfocus();
    }

    passwordVisibility[field] = !passwordVisibility[field]!;
    update();
  }

  saveCode(String code) {
    otp = code;
  }

  checkOtp() {
    if (otp == '1234') {
      return true;
    }
    Get.snackbar(ManagerStrings.otpSendError,
        ManagerStrings.theCodeThatYouEnteredIsWrong,
        snackPosition: SnackPosition.TOP,
        backgroundColor: ManagerColors.primaryColor,
        colorText: ManagerColors.white);
    return false;
  }

  navigateToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 2), curve: Curves.bounceInOut);
  }

  navigateToRegister() {
    Get.toNamed(Routes.register);
  }

  int isLoading = 0;

  Future<void> signIn() async {
    isLoading = 1;
    update();
    await supabase.auth
        .signInWithPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then(
      (value) {
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setUserLoggedIn();
        CacheData.setEmail(value: emailController.text);
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
        duration: const Duration(
          milliseconds: Constants.sessionFinishedDuration,
        ),
      );
      isLoading = 0;
      update();
    });
  }

  Future<void> resendVerificationEmail() async {
    await supabase.auth
        .signInWithOtp(
      email: emailController.text,
    )
        .then(
      (value) {
        Get.snackbar(
          ManagerStrings.emailVerificationLinkSent,
          '',
          duration: const Duration(
            milliseconds: Constants.sessionFinishedDuration,
          ),
        );
      },
    ).catchError((error) {
      Get.snackbar(
        error,
        '',
        duration: const Duration(
          milliseconds: Constants.sessionFinishedDuration,
        ),
      );
    });
  }

  navigateToMain() {
    Get.toNamed(Routes.mainHome);
  }

  performLogin() {
    if (formKey.currentState!.validate()) {
      signIn();
    }
  }

  login() async {
    LoginUseCase useCase = instance<LoginUseCase>();
    (await useCase.execute(LoginRequest(
            email: emailController.text, password: passwordController.text)))
        .fold(
      (l) {},
      (r) {
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setUserLoggedIn();
        prefs.setToken(token: r.data.token);
        CacheData.setEmail(value: emailController.text);
        navigateToMain();
      },
    );
  }

  late final EmailService _emailService;

  void initEmailService() async {
    _emailService = await EmailService.create();
  }

  void sendOtpToUser(String email, String otp) {
    _emailService.sendOtpEmail(email, otp);
  }

  @override
  void onClose() {
    formKey.currentState!.dispose;
    super.onClose();
  }

  @override
  void onInit() {
    initEmailService();
    super.onInit();
  }
}
