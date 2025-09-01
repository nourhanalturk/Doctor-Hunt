import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/appointment_repository.dart';
import '../../data/request/appointment_request.dart';
import '../model/appointment_model.dart';

class AddAppointmentUseCase implements BaseUseCase<AddAppointmentRequest, AppointmentModel> {
  final AddAppointmentRepository repository;

  AddAppointmentUseCase(this.repository);

  @override
  Future<Either<Failure, AppointmentModel>> execute(AddAppointmentRequest request) async {
    return await repository.addAppointment(request);
  }
}