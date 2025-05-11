import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/error_handler/server_faiure.dart';
import 'package:tender/features/register/data/mapper/add_patient_mapper.dart';
import 'package:tender/features/register/data/request/add_patient_request.dart';

import '../../domain/model/patients_model.dart';
import '../data_source/add_patient_remote_data_source.dart';

abstract class AddPatientRepository {
  Future<Either<Failure, PatientModel>> addPatient(AddPatientRequest request);
}

class AddPatientRepositoryImpl implements AddPatientRepository {
  final AddPatientRemoteDataSource dataSource;

  AddPatientRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, PatientModel>> addPatient(AddPatientRequest request) async {
    try {
      final response = await dataSource.addPatient(request);
      return Right(response.toDomain());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
