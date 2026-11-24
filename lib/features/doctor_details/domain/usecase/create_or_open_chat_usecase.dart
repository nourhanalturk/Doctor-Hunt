import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/create_or_open_chat_repository.dart';
import '../model/chat_uid_model.dart';

class CreateOrOpenChatUseCase implements BaseUseCase<int, ChatUidModel> {
  final CreateOrOpenChatRepository repository;

  CreateOrOpenChatUseCase(this.repository);

  @override
  Future<Either<Failure, ChatUidModel>> execute(int doctorId) =>
      repository.createOrOpenChat(doctorId);
}
