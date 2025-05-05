import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/doctor_details/data/mapper/doctor_details_mapper.dart';
import 'package:tender/features/doctor_details/data/request/doctor_details_request.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_faiure.dart';
import '../../domain/model/doctor_details_model.dart';
import '../data_source/doctor_details_remote_data_source.dart';

abstract class DoctorDetailsRepository {
  Future<Either<Failure, DoctorDetailsModel>> getDoctorDetails(DoctorDetailsRequest request);
}

class DoctorDetailsRepositoryImpl implements DoctorDetailsRepository {
  final DoctorDetailsRemoteDataSource dataSource;

  DoctorDetailsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, DoctorDetailsModel>> getDoctorDetails(DoctorDetailsRequest request) async {
    try {
      final response = await dataSource.getDoctorDetails(request.doctorId);
      return Right(response.first.toDomain());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}