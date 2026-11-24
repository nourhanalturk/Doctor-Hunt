import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';

abstract class NetworkConnectionRepository {
  Future<Either<Failure, bool>> isConnected();
}

class NetworkConnectionRepositoryImpl implements NetworkConnectionRepository {
  final NetworkInfo networkInfo;

  NetworkConnectionRepositoryImpl(this.networkInfo);

  @override
  Future<Either<Failure, bool>> isConnected() async {
    if (await networkInfo.isConnected) {
      return const Right(true);
    }

    return Left(
      Failure(
        ResponseCode.noInternetConnection,
        ManagerStrings.noInternetConnection,
      ),
    );
  }
}
