import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tender/core/error_handler/data_source_extension.dart';
import 'package:tender/core/error_handler/response_code.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/error_handler/type_handler_enum.dart';
import '../../config/constants/constants.dart';

import '../../config/di/di.dart';
import '../resources/manager_strings.dart';
import '../routes/routes.dart';
import '../storage/local/app_settings_prefs.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  AppSettingsPrefs appSettings = instance<AppSettingsPrefs>();

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode ?? ResponseCode.badRequest;
      final data = response?.data;

      if (statusCode == ResponseCode.unAuthorized) {
        Future.delayed(
          const Duration(seconds: Constants.sessionFinishedDuration),
              () {
            appSettings.clear();
            Get.offAllNamed(Routes.login);
          },
        );
        failure = Failure(
          statusCode,
          ManagerStrings.sessionFinished,
        );
      } else if (data != null) {
        final errorMessage = _extractMessageFromData(data);
        failure = Failure(statusCode, errorMessage);
      } else {
        final customMessage = _mapSupabaseError(error.message?.toString() ?? error.toString());
        failure = Failure(statusCode, customMessage);
      }
    } else {
      final customMessage = _mapSupabaseError(error.toString());
      failure = Failure(ResponseCode.unKnown, customMessage);
    }
  }

  String _extractMessageFromData(dynamic data) {
    try {
      return data[Constants.message] ??
          data[Constants.error]?[Constants.message] ??
          data[Constants.errors]?.values.first.first ??
          Constants.error;
    } catch (_) {
      return Constants.error;
    }
  }

  String _mapSupabaseError(String message) {
    message = message.toLowerCase();

    if (message.contains('payload too large') || message.contains('413')) {
      return ManagerStrings.payloadTooLarge;
    } else if (message.contains('unauthorized')) {
      return ManagerStrings.unauthorized;
    } else if (message.contains('bucket') && message.contains('not found')) {
      return ManagerStrings.bucketNotFound;
    } else if (message.contains('quota') && message.contains('exceeded')) {
      return ManagerStrings.quotaExceeded;
    } else if (message.contains('connection reset by peer') ||
        message.contains('network') ||
        message.contains('socketexception')) {
      return ManagerStrings.networkError;
    }

    return ManagerStrings.unknownError;
  }
}

