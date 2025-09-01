import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';

import '../../data/repository/profile_repository.dart';

class ProfileUsecase extends BaseUseCase<ProfileRequest, void> {
  ProfileRepository repository;

  ProfileUsecase(this.repository);

  @override
  Future<Either<Failure, void>> execute(ProfileRequest request) async {
    return await repository.profile(request);
  }
}
