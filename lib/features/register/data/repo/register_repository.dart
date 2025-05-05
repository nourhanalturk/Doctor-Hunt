import 'package:dartz/dartz.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/register/data/mapper/register_mapper.dart';
import '../../../../config/constants/response_constants.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/internet_checker/interent_checker.dart';
import '../../domain/model/register_model.dart';
import '../data_source/register_remote_data_source.dart';
import '../request/register_request.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterModel>> register(RegisterRequest request);
}

class RegisterRepositoryImplement implements RegisterRepository {
  RegisterRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  RegisterRepositoryImplement(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, RegisterModel>> register(
      RegisterRequest request) async {
    if (true) {
      // todo : for real Backend write (await networkInfo.isConnected)
      try {
        final response = await remoteDataSource.register(
          request,
        );
        return Right(
          response.toDomain(),
        );
      } catch (e) {
        return Left(
          ErrorHandler.handle(e).failure,
        );
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
