import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/chats_repository.dart';
import '../model/doctors_data_model.dart';

class GetDoctorsDetailsUseCase
    implements BaseUseCase<List<int>, List<DoctorDataModel>> {
  final ChatsRepository repository;

  GetDoctorsDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DoctorDataModel>>> execute(
    List<int> doctorIds,
  ) =>
      repository.getDoctorsDetails(doctorIds);
}
