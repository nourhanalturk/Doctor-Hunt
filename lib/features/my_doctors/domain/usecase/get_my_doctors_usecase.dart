import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/my_doctors_repository.dart';

class GetMyDoctorsUseCase implements BaseGetUseCase<List<int>> {
  final MyDoctorsRepository repository;

  GetMyDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<int>>> execute() => repository.getDoctorIds();
}
