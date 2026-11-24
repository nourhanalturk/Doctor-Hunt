import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/profile_records_info/data/repository/patient_records_repository.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_records_model.dart';

class GetPatientRecordsUseCase
    implements BaseUseCase<String, List<PatientRecordsModel>> {
  final PatientRecordsRepository repository;

  GetPatientRecordsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PatientRecordsModel>>> execute(
    String userId,
  ) async {
    return repository.getPatientRecords(userId);
  }
}
