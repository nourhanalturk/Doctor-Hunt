import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/resources/manager_strings.dart';
import '../data_source/current_user_data_source.dart';

abstract class CurrentUserRepository {
  Either<Failure, String> getCurrentUserId();
}

class CurrentUserRepositoryImpl implements CurrentUserRepository {
  final CurrentUserDataSource dataSource;

  CurrentUserRepositoryImpl(this.dataSource);

  @override
  Either<Failure, String> getCurrentUserId() {
    final userId = dataSource.getCurrentUserId();

    if (userId == null) {
      return Left(
        Failure(ResponseCode.unAuthorized, ManagerStrings.unAuthorized),
      );
    }

    return Right(userId);
  }
}
