import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';
import '../../../../core/error_handler/server_failure.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/model/message_model.dart';
import '../data_source/messages_remote_data_source.dart';
import '../mapper/message_mapper.dart';
import '../request/send_message_request.dart';

abstract class MessagesRepository {
  Future<Either<Failure, List<MessageModel>>> getMessages(String chatUid);

  Future<Either<Failure, bool>> sendMessage(SendMessageRequest request);

  Future<Either<Failure, Stream<MessageModel>>> listenToNewMessages(
    String chatUid,
  );
}

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MessagesRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(
    String chatUid,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getMessages(chatUid);
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
  Future<Either<Failure, bool>> sendMessage(SendMessageRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendMessage(request);
        return const Right(true);
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
  Future<Either<Failure, Stream<MessageModel>>> listenToNewMessages(
    String chatUid,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final stream = remoteDataSource.listenToNewMessages(chatUid);
        return Right(stream.map((e) => e.toDomain()));
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
