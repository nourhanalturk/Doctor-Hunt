import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/internet_checker/interent_checker.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/home/data/mapper/home_data_mapper.dart';

import '../../../../config/constants/response_constants.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/server_faiure.dart';
import '../../domain/model/home_data_model.dart';
import '../data_source/home_data_remote_data_source.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeModel>>> getHomeSections();
//Future<Either<Failure, void>> addHomeSection(HomeModel model);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource dataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<HomeModel>>> getHomeSections() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getHomeSections();
        return Right(response.map((r) => r.toDomain()).toList());
      } on PostgrestException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }
    } else {
      return Left(
        Failure(
          ResponseCode.noInternetConnection,
          ManagerStrings.noInternetConnection,
        ),
      );
    }
  }

}
