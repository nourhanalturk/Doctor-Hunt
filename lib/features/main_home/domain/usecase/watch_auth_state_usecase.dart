import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/auth_state_repository.dart';
import '../model/auth_state_model.dart';

class WatchAuthStateUseCase implements BaseGetUseCase<Stream<AuthStateModel>> {
  final AuthStateRepository repository;

  WatchAuthStateUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<AuthStateModel>>> execute() async =>
      Right(repository.watchAuthState());
}
