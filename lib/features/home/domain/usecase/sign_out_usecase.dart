import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/sign_out_repository.dart';

class SignOutUseCase implements BaseGetUseCase<bool> {
  final SignOutRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute() async => repository.signOut();
}
