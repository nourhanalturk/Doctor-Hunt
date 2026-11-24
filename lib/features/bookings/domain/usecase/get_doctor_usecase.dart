import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/get_doctor_repository.dart';
import '../../data/request/get_doctor_request.dart';
import '../model/doctor_name_model.dart';

class GetDoctorUseCase implements BaseUseCase<GetDoctorRequest, DoctorNameModel> {
  final GetDoctorRepository repository;

  GetDoctorUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorNameModel>> execute(
    GetDoctorRequest request,
  ) =>
      repository.getDoctor(request);
}
