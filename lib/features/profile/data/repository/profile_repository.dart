import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/error_handler.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';
import '../../../../config/constants/response_constants.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../data_source/profile_remote_data_source.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> profile(ProfileRequest request);
}

class ProfileRepositoryImplementation implements ProfileRepository {
  NetworkInfo networkInfo;

  ProfileRemoteDataSource dataSource;

  ProfileRepositoryImplementation(this.networkInfo, this.dataSource);

  @override
  Future<Either<Failure, void>> profile(ProfileRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        final response = dataSource.profile(request);
        return right(response);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }
  }
}
