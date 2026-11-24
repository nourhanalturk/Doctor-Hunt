import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/medical_records/data/repository/medical_records_repository.dart';
import 'package:tender/features/medical_records/data/request/add_medical_record_request.dart';

class AddMedicalRecordUseCase
    implements BaseUseCase<AddMedicalRecordRequest, Unit> {
  final MedicalRecordsRepository repository;

  AddMedicalRecordUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> execute(AddMedicalRecordRequest request) async {
    return repository.addMedicalRecord(request);
  }
}
