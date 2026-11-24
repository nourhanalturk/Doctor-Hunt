import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/auth_repository.dart';

class ResendOtpUseCase implements BaseUseCase<String, void> {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(String email) async =>
      repository.resendVerificationEmail(email);
}
