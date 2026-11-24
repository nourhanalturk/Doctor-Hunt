import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/core/validator/validator.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/service/email_service.dart';
import '../../data/request/sign_in_request.dart';
import '../../domain/model/auth_failure.dart';
import '../../domain/usecase/is_email_unconfirmed_usecase.dart';
import '../../domain/usecase/resend_otp_usecase.dart';
import '../../domain/usecase/sign_in_usecase.dart';
import 'login_ui_constants.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController confirmResetPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formKey => _formKey;
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

    final result = await instance<SignInUseCase>().execute(
      SignInRequest(
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
          duration: LoginUiConstants.snackbarDuration,
        );
        isLoading = 0;
        update();
      },
      (signInResult) async {
        AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
        prefs.setIsUserLoggedIn(true);
        navigateToMain();
        isLoading = 0;
        update();
      },
    );
  }

  Future<void> resendVerificationEmail() async {
    final result =
        await instance<ResendOtpUseCase>().execute(emailController.text);

    result.fold(
      (failure) {
        final authFailure = failure is AuthFailure ? failure : null;
        Get.snackbar(
          authFailure?.dialogMessage ?? failure.message,
          '',
          duration: LoginUiConstants.snackbarDuration,
        );
      },
      (_) {
        Get.snackbar(
          ManagerStrings.emailVerificationLinkSent,
          '',
          duration: LoginUiConstants.snackbarDuration,
        );
      },
    );
  }

  navigateToMain() {
    Get.offAllNamed(Routes.mainHome);
  }

  performLogin() {
    if (formKey.currentState!.validate()) {
      signIn();
    }
  }

  late final EmailService _emailService;

  void initEmailService() async {
    _emailService = await EmailService.create();
  }

  void sendOtpToUser(String email, String otp) {
    _emailService.sendOtpEmail(email, otp);
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    initEmailService();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordEmailController.dispose();
    resetPasswordController.dispose();
    confirmResetPasswordController.dispose();
    pageController.dispose();
    passwordFocusNode.dispose();
    resetPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }
}
