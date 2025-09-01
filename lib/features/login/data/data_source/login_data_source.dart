import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tender/core/extensions/extensions.dart';
import '../../../../config/constants/env_constants.dart';
import '../../../../core/network/app_api.dart';
import '../../../../core/resources/manager_mockup.dart';
import '../request/login_request.dart';
import '../response/login_response.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginRemoteDataSourceImplement implements LoginRemoteDataSource {
  final AppService _appService;

  LoginRemoteDataSourceImplement(this._appService);



  @override
  Future<LoginResponse> login(LoginRequest request) async {
    if (dotenv.env[EnvConstants.debug].onNullBool()) {
      return LoginResponse.fromJson(
        json.decode(
          await rootBundle.rootBundle.loadString(
            ManagerMockUp.login,
          ),
        ),
      );
    }
    return await _appService.login(
      request.email,
      request.password,
    );
  }
}
