import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tender/core/extensions/extensions.dart';

import '../../../../config/constants/env_constants.dart';
import '../../../../core/network/app_api.dart';
import '../../../../core/resources/manager_mockup.dart';
import '../request/register_request.dart';
import '../response/register_response.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

abstract class RegisterRemoteDataSource {
  Future<RegisterResponse> register(RegisterRequest request);
}

class RegisterRemoteDataSourceImplementation
    implements RegisterRemoteDataSource {
  AppService appService;

  RegisterRemoteDataSourceImplementation(this.appService);

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    if (dotenv.env[EnvConstants.debug].onNullBool()) {
      return RegisterResponse.fromJson(
        json.decode(
          await rootBundle.rootBundle.loadString(
            ManagerMockUp.register,
          ),
        ),
      );
    }
    return await appService.register(
      request.name,
      request.name,
      request.password,
    );
  }
}
