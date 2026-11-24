import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/my_doctors_repository.dart';
import '../model/my_doctors_model.dart';

class GetMyDoctorsDetailsUseCase
    implements BaseUseCase<List<int>, List<MyDoctorsModel>> {
  final MyDoctorsRepository repository;

  GetMyDoctorsDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MyDoctorsModel>>> execute(
    List<int> doctorIds,
  ) =>
      repository.getDoctorDetails(doctorIds);
}
