import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/doctor_name_model.dart';
import '../data_source/get_doctor_remote_data_source.dart';
import '../mapper/get_doctor_mapper.dart';
import '../request/get_doctor_request.dart';

abstract class GetDoctorRepository {
  Future<Either<Failure, DoctorNameModel>> getDoctor(GetDoctorRequest request);
}

class GetDoctorRepositoryImpl implements GetDoctorRepository {
  final GetDoctorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetDoctorRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, DoctorNameModel>> getDoctor(
    GetDoctorRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDoctor(request);
        return Right(response.toDomain());
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
