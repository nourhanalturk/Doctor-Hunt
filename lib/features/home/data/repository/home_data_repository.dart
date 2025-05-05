import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/home/data/mapper/home_data_mapper.dart';

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

  HomeRepositoryImpl(this.dataSource);


  @override
  Future<Either<Failure, List<HomeModel>>> getHomeSections() async {
    try {
      final response = await dataSource.getHomeSections();
      return Right(response.map((r) => r.toDomain()).toList());
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }


  // @override
  // Future<Either<Failure, void>> addHomeSection(HomeModel model) async {
  //   try {
  //     await dataSource.addHomeSection({
  //       'section': model.section.name,
  //       'name': model.name,
  //       'image': model.image,
  //       'is_live': model.isLive,
  //       'specialty': model.specialty,
  //       'rating': model.rating,
  //       'coast_per_hour': model.coastPerHour,
  //     });
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}