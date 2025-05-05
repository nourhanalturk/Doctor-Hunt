import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tender/core/network/dio_factory.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_opacity.dart';

import '../resources/manager_strings.dart';

class EmailService {
  final Dio dio;

  EmailService._internal(this.dio); // private constructor

  static Future<EmailService> create() async {
    final getIt = GetIt.I;

    if (!getIt.isRegistered<Dio>()) {
      if (!getIt.isRegistered<DioFactory>()) {
        getIt.registerLazySingleton<DioFactory>(() => DioFactory());
      }

      final dioFactory = getIt<DioFactory>();
      final dio = await dioFactory.getDio();

      getIt.registerLazySingleton<Dio>(() => dio);
    }

    return EmailService._internal(getIt<Dio>());
  }

  Future<void> sendOtpEmail(String userEmail, String otp) async {
    try {
      final response = await dio.post(
        'https://api.emailjs.com/api/v1.0/email/send',
        options: Options(
          headers: {
            'origin': 'https://yourdomain.com',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'service_id': 'service_knoxx9n',
          'template_id': 'template_lpvqk5q',
          'user_id': 'bW7X28Cy7TXEl26wZ',
          'accessToken': 'Dv1RuzcYLfrAyU13ND40T',
          'template_params': {
            'user_email': userEmail,
            'otp': otp,
            'time': DateTime.now().add(const Duration(minutes: 15)).toString(),
            'email':userEmail
          }
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
            ManagerStrings.otpSentSuccessfully,
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: ManagerColors.primaryColor,
            colorText: ManagerColors.white
        );      } else {
        Get.snackbar(
            ManagerStrings.otpSendError,
            'Status Code: ${response.statusCode}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: ManagerColors.redColor,
            colorText: ManagerColors.white
        );
      }
    } catch (e) {
        Get.snackbar(
            ManagerStrings.failedToSendOtp,
            'Error: ${e}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: ManagerColors.redColor,
            colorText: ManagerColors.white
        );

    }


}
}
