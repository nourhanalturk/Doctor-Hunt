import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';

import '../../data/repository/current_user_repository.dart';

class GetCurrentUserIdUseCase implements BaseGetUseCase<String> {
  final CurrentUserRepository repository;

  GetCurrentUserIdUseCase(this.repository);

  @override
  Future<Either<Failure, String>> execute() async {
    return repository.getCurrentUserId();
  }
}
