import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/favorites_repository.dart';

class GetFavoritesUseCase implements BaseUseCase<String, List<int>> {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, List<int>>> execute(String userId) async {
    return await repository.getFavorites(userId);
  }
}

class ToggleFavoriteUseCase implements BaseUseCase<Map<String, dynamic>, void> {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(Map<String, dynamic> params) async {
    return await repository.toggleFavorite(
      params['userId'] as String,
      params['doctorId'] as int,
    );
  }
}