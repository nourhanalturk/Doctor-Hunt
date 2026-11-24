import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/chat_model.dart';
import '../../domain/model/doctors_data_model.dart';
import '../data_source/chats_remote_data_source.dart';
import '../mapper/chat_mapper.dart';

abstract class ChatsRepository {
  Future<Either<Failure, List<ChatModel>>> getChats();

  Future<Either<Failure, List<DoctorDataModel>>> getDoctorsDetails(
    List<int> doctorIds,
  );
}

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ChatModel>>> getChats() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getChats();
        return Right(response.map((e) => e.toDomain()).toList());
      } catch (e) {
        return Left(ServerFailure('${ManagerStrings.unexpectedError}: $e'));
      }
    }

    return Left(
      Failure(
        ResponseCode.noInternetConnection,
        ManagerStrings.noInternetConnection,
      ),
    );
  }

  @override
  Future<Either<Failure, List<DoctorDataModel>>> getDoctorsDetails(
    List<int> doctorIds,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDoctorsDetails(doctorIds);
        return Right(response.map((e) => e.toDomain()).toList());
      } catch (e) {
        return Left(ServerFailure('${ManagerStrings.unexpectedError}: $e'));
      }
    }

    return Left(
      Failure(
        ResponseCode.noInternetConnection,
        ManagerStrings.noInternetConnection,
      ),
    );
  }
}
