import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/request/sign_in_request.dart';
import '../model/sign_in_model.dart';

class SignInUseCase implements BaseUseCase<SignInRequest, SignInModel> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, SignInModel>> execute(SignInRequest request) async =>
      repository.signInWithPassword(request);
}
