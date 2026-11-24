import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/available_times_repository.dart';
import '../../data/request/get_available_times_request.dart';
import '../model/available_time_model.dart';

class GetAvailableTimesUseCase
    implements BaseUseCase<GetAvailableTimesRequest, List<AvailableTimeModel>> {
  final AvailableTimesRepository repository;

  GetAvailableTimesUseCase(this.repository);

  @override
  Future<Either<Failure, List<AvailableTimeModel>>> execute(
    GetAvailableTimesRequest request,
  ) {
    return repository.getAvailableTimes(request);
  }
}
