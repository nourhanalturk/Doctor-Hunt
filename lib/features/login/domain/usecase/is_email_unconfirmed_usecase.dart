import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/auth_repository.dart';

class IsEmailUnconfirmedUseCase implements BaseGetUseCase<bool> {
  final AuthRepository repository;

  IsEmailUnconfirmedUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute() async =>
      repository.isEmailUnconfirmed();
}
