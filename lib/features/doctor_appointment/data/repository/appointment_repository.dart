import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/doctor_appointment/data/mapper/appointment_mapper.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_faiure.dart';
import '../../model/model/appointment_model.dart';
import '../data_source/appointment.dart';
import '../request/appointment_request.dart';

abstract class AddAppointmentRepository {
  Future<Either<Failure, AppointmentModel>> addAppointment(AddAppointmentRequest request);
}

class AddAppointmentRepositoryImpl implements AddAppointmentRepository {
  final AddAppointmentRemoteDataSource dataSource;

  AddAppointmentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AppointmentModel>> addAppointment(AddAppointmentRequest request) async {
    try {
      final response = await dataSource.addAppointment(request);
      return Right(response.toDomain());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
