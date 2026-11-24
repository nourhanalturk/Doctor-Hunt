import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';

import '../../data/repository/favorites_repository.dart';
import '../model/favorite_doctor_model.dart';

class GetFavoriteDoctorsUseCase
    implements BaseUseCase<String, List<FavoriteDoctorModel>> {
  final FavoritesRepository repository;

  GetFavoriteDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FavoriteDoctorModel>>> execute(
    String userId,
  ) async {
    return repository.getFavoriteDoctors(userId);
  }
}
