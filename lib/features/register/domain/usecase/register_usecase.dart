import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repo/register_repository.dart';
import '../../data/request/register_request.dart';
import '../model/register_model.dart';

class RegisterUseCase extends BaseUseCase<RegisterRequest, RegisterModel> {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, RegisterModel>> execute(RegisterRequest input) async {
    return await repository.register(
      input,
    );
  }
}
