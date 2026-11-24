import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/response_constants.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/error_handler/server_failure.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/medical_records/data/mapper/record_image_mapper.dart';
import 'package:tender/features/medical_records/data/data_source/medical_records_remote_data_source.dart';
import 'package:tender/features/medical_records/data/request/add_medical_record_request.dart';
import 'package:tender/features/medical_records/domain/model/record_image_model.dart';

abstract class MedicalRecordsRepository {
  Future<Either<Failure, RecordImageModel>> uploadRecordImage(File image);

  Future<Either<Failure, Unit>> addMedicalRecord(AddMedicalRecordRequest request);
}

class MedicalRecordsRepositoryImpl implements MedicalRecordsRepository {
  final MedicalRecordsRemoteDataSource dataSource;
  final NetworkInfo networkInfo;

  MedicalRecordsRepositoryImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, RecordImageModel>> uploadRecordImage(File image) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      final response = await dataSource.uploadRecordImage(image);
      return Right(response.toDomain());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMedicalRecord(
    AddMedicalRecordRequest request,
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
      await dataSource.addMedicalRecord(request);
      return right(unit);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
