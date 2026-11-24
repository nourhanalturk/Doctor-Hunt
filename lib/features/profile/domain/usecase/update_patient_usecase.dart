import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/profile/data/repository/profile_repository.dart';
import 'package:tender/features/profile/data/request/update_patient_request.dart';

class UpdatePatientUseCase implements BaseUseCase<UpdatePatientRequest, void> {
  final ProfileRepository repository;

  UpdatePatientUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(UpdatePatientRequest request) async {
    return repository.updatePatient(request);
  }
}
