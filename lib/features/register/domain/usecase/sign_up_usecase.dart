import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/register_auth_repository.dart';
import '../../data/request/sign_up_request.dart';
import '../model/sign_up_model.dart';

class SignUpUseCase implements BaseUseCase<SignUpRequest, SignUpModel> {
  final RegisterAuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, SignUpModel>> execute(SignUpRequest request) async {
    return repository.signUp(request);
  }
}
