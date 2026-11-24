import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/my_doctors_model.dart';
import '../data_source/my_doctors_remote_data_source.dart';
import '../mapper/my_doctors_mapper.dart';

abstract class MyDoctorsRepository {
  Future<Either<Failure, List<int>>> getDoctorIds();

  Future<Either<Failure, List<MyDoctorsModel>>> getDoctorDetails(
    List<int> doctorIds,
  );
}

class MyDoctorsRepositoryImpl implements MyDoctorsRepository {
  final MyDoctorsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MyDoctorsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<int>>> getDoctorIds() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDoctorIds();
        final doctorIds = response
            .map((e) => e.doctorId)
            .whereType<int>()
            .toSet()
            .toList();
        return Right(doctorIds);
      } catch (e) {
        return Left(ServerFailure('${ManagerStrings.unexpectedError}: $e'));
      }
    }

    return Left(
      Failure(
        ResponseCode.noInternetConnection,
        ManagerStrings.noInternetConnection,
      ),
    );
  }

  @override
  Future<Either<Failure, List<MyDoctorsModel>>> getDoctorDetails(
    List<int> doctorIds,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDoctorDetails(doctorIds);
        return Right(response.map((e) => e.toDomain()).toList());
      } catch (e) {
        return Left(ServerFailure('${ManagerStrings.unexpectedError}: $e'));
      }
    }

    return Left(
      Failure(
        ResponseCode.noInternetConnection,
        ManagerStrings.noInternetConnection,
      ),
    );
  }
}
