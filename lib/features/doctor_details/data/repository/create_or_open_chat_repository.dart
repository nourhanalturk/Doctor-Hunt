import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/chat_uid_model.dart';
import '../data_source/create_or_open_chat_remote_data_source.dart';
import '../mapper/chat_mapper.dart';

abstract class CreateOrOpenChatRepository {
  Future<Either<Failure, ChatUidModel>> createOrOpenChat(int doctorId);
}

class CreateOrOpenChatRepositoryImpl implements CreateOrOpenChatRepository {
  final CreateOrOpenChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CreateOrOpenChatRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChatUidModel>> createOrOpenChat(int doctorId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.createOrOpenChat(doctorId);
        return Right(response.toDomain());
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
