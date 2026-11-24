import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/network_connection_repository.dart';

class CheckInternetConnectionUseCase implements BaseGetUseCase<bool> {
  final NetworkConnectionRepository repository;

  CheckInternetConnectionUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute() async => repository.isConnected();
}
