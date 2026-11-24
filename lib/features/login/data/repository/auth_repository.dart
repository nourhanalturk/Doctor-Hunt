import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/auth_failure.dart';
import '../../domain/model/sign_in_model.dart';
import '../data_source/auth_data_source_exception.dart';
import '../data_source/auth_remote_data_source.dart';
import '../mapper/sign_in_mapper.dart';
import '../request/sign_in_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignInModel>> signInWithPassword(SignInRequest request);

  Either<Failure, bool> isEmailUnconfirmed();

  Future<Either<Failure, void>> resendVerificationEmail(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, SignInModel>> signInWithPassword(
    SignInRequest request,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      final response = await remoteDataSource.signInWithPassword(request);
      return Right(response.toDomain());
    } on AuthDataSourceException catch (e) {
      return Left(
        AuthFailure(message: e.message, dialogMessage: e.rawMessage),
      );
    } catch (e) {
      return Left(
        AuthFailure(
          message: ManagerStrings.unknown,
          dialogMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Either<Failure, bool> isEmailUnconfirmed() {
    try {
      return Right(remoteDataSource.isEmailUnconfirmed());
    } catch (e) {
      return Left(
        AuthFailure(
          message: ManagerStrings.unknown,
          dialogMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationEmail(String email) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      await remoteDataSource.resendVerificationEmail(email);
      return const Right(null);
    } on AuthDataSourceException catch (e) {
      return Left(
        AuthFailure(message: e.message, dialogMessage: e.rawMessage),
      );
    } catch (e) {
      return Left(
        AuthFailure(
          message: ManagerStrings.unknown,
          dialogMessage: e.toString(),
        ),
      );
    }
  }
}
