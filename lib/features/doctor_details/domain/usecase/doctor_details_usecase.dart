import 'package:dartz/dartz.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/doctor_details/data/request/doctor_details_request.dart';

import '../../../../core/error_handler/failure.dart';
import '../../data/repository/doctor_details_repository.dart';
import '../model/doctor_details_model.dart';

class DoctorDetailsUseCase
    extends BaseUseCase<DoctorDetailsRequest, DoctorDetailsModel> {
  final DoctorDetailsRepository repository;

  DoctorDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorDetailsModel>> execute(
      DoctorDetailsRequest request) async {
    return await repository.getDoctorDetails(
      DoctorDetailsRequest(
        doctorId: request.doctorId,
      ),
    );
  }
}
