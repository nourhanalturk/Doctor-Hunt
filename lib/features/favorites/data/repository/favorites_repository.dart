import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/resources/manager_strings.dart';
import '../data_source/favorites_remote_data_source.dart';

class FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;

  FavoritesRepository(this._remoteDataSource);

  Future<Either<Failure, List<int>>> getFavorites(String userId) async {
    try {
      final favorites = await _remoteDataSource.getFavorites(userId);
      return Right(favorites);
    } catch (e) {
      return Left(ServerFailure(ManagerStrings.unexpectedError));
    }
  }

  Future<Either<Failure, void>> toggleFavorite(String userId, int doctorId) async {
    try {
      await _remoteDataSource.toggleFavorite(userId, doctorId);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('Unknown error: ${e.toString()}'));
    }
  }
}