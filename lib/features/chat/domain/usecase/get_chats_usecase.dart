import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/chats_repository.dart';
import '../model/chat_model.dart';

class GetChatsUseCase implements BaseGetUseCase<List<ChatModel>> {
  final ChatsRepository repository;

  GetChatsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChatModel>>> execute() => repository.getChats();
}
