import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/response_constants.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/available_time_model.dart';
import '../data_source/available_times_remote_data_source.dart';
import '../mapper/available_times_mapper.dart';
import '../request/get_available_times_request.dart';
import '../request/update_available_time_request.dart';

abstract class AvailableTimesRepository {
  Future<Either<Failure, List<AvailableTimeModel>>> getAvailableTimes(
    GetAvailableTimesRequest request,
  );

  Future<Either<Failure, bool>> updateDoctorAvailableTime(
    UpdateAvailableTimeRequest request,
  );
}

class AvailableTimesRepositoryImpl implements AvailableTimesRepository {
  final AvailableTimesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AvailableTimesRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<AvailableTimeModel>>> getAvailableTimes(
    GetAvailableTimesRequest request,
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
      final response = await remoteDataSource.getAvailableTimes(request);
      return Right(response.toDomain(request.date));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('${ManagerStrings.unexpectedError}: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> updateDoctorAvailableTime(
    UpdateAvailableTimeRequest request,
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
      await remoteDataSource.updateDoctorAvailableTime(request);
      return const Right(true);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('${ManagerStrings.unexpectedError}: ${e.toString()}'),
      );
    }
  }
}
