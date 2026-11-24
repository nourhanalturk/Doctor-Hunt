import 'package:dartz/dartz.dart';
import 'package:tender/config/constants/response_constants.dart';
import 'package:tender/core/error_handler/error_handler.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/profile/data/mapper/uploaded_image_mapper.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';
import 'package:tender/features/profile/data/request/update_patient_request.dart';
import 'package:tender/features/profile/data/request/upload_profile_image_request.dart';
import 'package:tender/features/profile/domain/model/uploaded_image_model.dart';

import '../data_source/profile_remote_data_source.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> profile(ProfileRequest request);

  Future<Either<Failure, void>> updatePatient(UpdatePatientRequest request);

  Future<Either<Failure, UploadedImageModel>> uploadProfileImage(
    UploadProfileImageRequest request,
  );
}

class ProfileRepositoryImplementation implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource dataSource;

  ProfileRepositoryImplementation(this.networkInfo, this.dataSource);

  @override
  Future<Either<Failure, void>> profile(ProfileRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        await dataSource.profile(request);
        return const Right(null);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updatePatient(
    UpdatePatientRequest request,
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
      await dataSource.updatePatient(request);
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, UploadedImageModel>> uploadProfileImage(
    UploadProfileImageRequest request,
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
      final response = await dataSource.uploadProfileImage(request);
      return Right(response.toDomain());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
