import 'package:tender/features/login/data/mapper/login_mapper.dart';

import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/internet_checker/interent_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import 'package:dartz/dartz.dart';
import '../../domain/model/login_model.dart';
import '../data_source/login_data_source.dart';
import '../request/login_request.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login(
    LoginRequest request,
  );
}

class LoginRepositoryImplement implements LoginRepository {
  LoginRemoteDataSource remoteDataSource;
  NetworkInfo _networkInfo;

  LoginRepositoryImplement(this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest request) async {
    if (true) { // await _networkInfo.isConnected
      try {
        final response = await remoteDataSource.login(request);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }
  }
}
