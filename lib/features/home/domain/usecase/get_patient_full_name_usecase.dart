import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/home_data_repository.dart';

class GetPatientFullNameUseCase implements BaseGetUseCase<String> {
  final HomeRepository repository;

  GetPatientFullNameUseCase(this.repository);

  @override
  Future<Either<Failure, String>> execute() async {
    return repository.getPatientFullName();
  }
}
