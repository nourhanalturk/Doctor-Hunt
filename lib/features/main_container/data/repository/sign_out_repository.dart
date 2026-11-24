import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../data_source/sign_out_data_source.dart';

abstract class SignOutRepository {
  Future<Either<Failure, bool>> signOut();
}

class SignOutRepositoryImpl implements SignOutRepository {
  final SignOutDataSource dataSource;
  final NetworkInfo networkInfo;

  SignOutRepositoryImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, bool>> signOut() async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      await dataSource.signOut();
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(
          ResponseCode.unKnown,
          '${ManagerStrings.unexpectedError}: ${e.toString()}',
        ),
      );
    }
  }
}
