import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/register_auth_repository.dart';

class ResendVerificationEmailUseCase implements BaseUseCase<String, void> {
  final RegisterAuthRepository repository;

  ResendVerificationEmailUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(String email) async =>
      repository.resendVerificationEmail(email);
}
