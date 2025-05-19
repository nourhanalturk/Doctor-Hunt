import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/doctor_appointment/data/mapper/appointment_mapper.dart';
import '../../../../config/constants/response_constants.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../model/model/appointment_model.dart';
import '../data_source/appointment.dart';
import '../request/appointment_request.dart';

abstract class AddAppointmentRepository {
  Future<Either<Failure, AppointmentModel>> addAppointment(AddAppointmentRequest request);
}

class AddAppointmentRepositoryImpl implements AddAppointmentRepository {
  final AddAppointmentRemoteDataSource dataSource;
  final NetworkInfo networkInfo ;

  AddAppointmentRepositoryImpl(this.dataSource ,this.networkInfo);

  @override
  Future<Either<Failure, AppointmentModel>> addAppointment(AddAppointmentRequest request) async {
    if(await networkInfo.isConnected){
      try {
        final response = await dataSource.addAppointment(request);
        return Right(response.toDomain());
      } on PostgrestException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('${ManagerStrings.unexpectedError}: ${e.toString()}'));
      }
    }else{
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

  }
}
