import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/messages_repository.dart';
import '../model/message_model.dart';

class GetMessagesUseCase implements BaseUseCase<String, List<MessageModel>> {
  final MessagesRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MessageModel>>> execute(String chatUid) =>
      repository.getMessages(chatUid);
}
