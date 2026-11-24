import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../doctor_appointment/domain/model/appointment_model.dart';
import '../../data/repository/get_appointments_repository.dart';

class GetAppointmentsUseCase
    implements BaseGetUseCase<List<AppointmentModel>> {
  final GetAppointmentsRepository repository;

  GetAppointmentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AppointmentModel>>> execute() {
    return repository.getAppointments();
  }
}
