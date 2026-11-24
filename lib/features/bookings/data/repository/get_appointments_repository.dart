import 'package:dartz/dartz.dart';
import 'package:tender/features/bookings/data/mapper/get_appointments_mapper.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../doctor_appointment/domain/model/appointment_model.dart';
import '../data_source/get_appointments_remote_data_source.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/resources/manager_strings.dart';

abstract class GetAppointmentsRepository {
  Future<Either<Failure, List<AppointmentModel>>> getAppointments();
}

class GetAppointmentsRepositoryImpl implements GetAppointmentsRepository {
  final GetAppointmentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetAppointmentsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<AppointmentModel>>> getAppointments() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAppointments();
        final appointments = response.map((e) => e.toDomain()).toList();
        return Right(appointments);
      } catch (e) {
        return Left(ServerFailure('${ManagerStrings.unexpectedError}: ${e.toString()}'));
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
