import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/response_constants.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/error_handler/server_failure.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/favorites/data/mapper/favorite_doctor_mapper.dart';
import 'package:tender/features/favorites/domain/model/favorite_doctor_model.dart';

import '../data_source/favorites_remote_data_source.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<int>>> getFavorites(String userId);

  Future<Either<Failure, void>> toggleFavorite(String userId, int doctorId);

  Future<Either<Failure, List<FavoriteDoctorModel>>> getFavoriteDoctors(
    String userId,
  );
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;
  final NetworkInfo networkInfo;

  FavoritesRepositoryImpl(this._remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<int>>> getFavorites(String userId) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      final favorites = await _remoteDataSource.getFavorites(userId);
      return Right(favorites);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(ManagerStrings.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(
    String userId,
    int doctorId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

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

  @override
  Future<Either<Failure, List<FavoriteDoctorModel>>> getFavoriteDoctors(
    String userId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }

    try {
      final response = await _remoteDataSource.getFavoriteDoctors(userId);
      return Right(response.map((e) => e.toDomain()).toList());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(ManagerStrings.unexpectedError));
    }
  }
}
