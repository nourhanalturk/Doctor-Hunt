import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/available_times_repository.dart';
import '../../data/request/update_available_time_request.dart';

class UpdateAvailableTimeUseCase
    implements BaseUseCase<UpdateAvailableTimeRequest, bool> {
  final AvailableTimesRepository repository;

  UpdateAvailableTimeUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute(UpdateAvailableTimeRequest request) {
    return repository.updateDoctorAvailableTime(request);
  }
}
