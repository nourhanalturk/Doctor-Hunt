import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/doctor_details/data/mapper/doctor_details_mapper.dart';
import 'package:tender/features/doctor_details/data/request/doctor_details_request.dart';
import '../../../../config/constants/response_constants.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/doctor_details_model.dart';
import '../data_source/doctor_details_remote_data_source.dart';

abstract class DoctorDetailsRepository {
  Future<Either<Failure, DoctorDetailsModel>> getDoctorDetails(
      DoctorDetailsRequest request);
}

class DoctorDetailsRepositoryImpl implements DoctorDetailsRepository {
  final DoctorDetailsRemoteDataSource dataSource;
  final NetworkInfo networkInfo;

  DoctorDetailsRepositoryImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, DoctorDetailsModel>> getDoctorDetails(
      DoctorDetailsRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getDoctorDetails(request.doctorId);
        return Right(response.first.toDomain());
      } on PostgrestException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(
          ServerFailure(
            e.toString(),
          ),
        );
      }
    } else {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }
  }
}
