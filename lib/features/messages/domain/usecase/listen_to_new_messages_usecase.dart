import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/messages_repository.dart';
import '../model/message_model.dart';

class ListenToNewMessagesUseCase
    implements BaseUseCase<String, Stream<MessageModel>> {
  final MessagesRepository repository;

  ListenToNewMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<MessageModel>>> execute(String chatUid) =>
      repository.listenToNewMessages(chatUid);
}
