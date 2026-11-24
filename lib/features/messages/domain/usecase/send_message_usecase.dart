import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/messages_repository.dart';
import '../../data/request/send_message_request.dart';

class SendMessageUseCase implements BaseUseCase<SendMessageRequest, bool> {
  final MessagesRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute(SendMessageRequest request) =>
      repository.sendMessage(request);
}
