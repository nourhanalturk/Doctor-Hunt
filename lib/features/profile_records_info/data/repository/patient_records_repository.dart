import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/response_constants.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/error_handler/server_failure.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/profile_records_info/data/data_source/patient_records_remote_data_source.dart';
import 'package:tender/features/profile_records_info/data/mapper/patient_mapper.dart';
import 'package:tender/features/profile_records_info/data/mapper/patient_records_mapper.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_model.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_records_model.dart';

abstract class PatientRecordsRepository {
  Future<Either<Failure, PatientModel>> getPatientInfo(String userId);

  Future<Either<Failure, List<PatientRecordsModel>>> getPatientRecords(
    String userId,
  );
}

class PatientRecordsRepositoryImpl implements PatientRecordsRepository {
  final PatientRecordsRemoteDataSource dataSource;
  final NetworkInfo networkInfo;

  PatientRecordsRepositoryImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, PatientModel>> getPatientInfo(String userId) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      final response = await dataSource.getPatientInfo(userId);
      return Right(response.toDomain());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PatientRecordsModel>>> getPatientRecords(
    String userId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      final response = await dataSource.getPatientRecords(userId);
      return Right(response.map((e) => e.toDomain()).toList());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
