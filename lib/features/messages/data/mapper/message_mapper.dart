import '../../domain/model/message_model.dart';
import '../response/message_response.dart';

extension MessageMapper on MessageResponse {
  MessageModel toDomain() => MessageModel(
        message: message,
        isSender: isSender,
      );
}
