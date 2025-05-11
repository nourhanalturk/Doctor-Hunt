import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repo/add_patient_repository.dart';
import '../../data/request/add_patient_request.dart';
import '../model/patients_model.dart';

class AddPatientUseCase implements BaseUseCase<AddPatientRequest, PatientModel> {
  final AddPatientRepository repository;

  AddPatientUseCase(this.repository);

  @override
  Future<Either<Failure, PatientModel>> execute(AddPatientRequest request) async {
    return await repository.addPatient(request);
  }
}
