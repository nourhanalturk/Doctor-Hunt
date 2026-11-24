import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/profile_records_info/data/repository/patient_records_repository.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_model.dart';

class GetPatientInfoUseCase implements BaseUseCase<String, PatientModel> {
  final PatientRecordsRepository repository;

  GetPatientInfoUseCase(this.repository);

  @override
  Future<Either<Failure, PatientModel>> execute(String userId) async {
    return repository.getPatientInfo(userId);
  }
}
