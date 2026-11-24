import '../../domain/model/chat_uid_model.dart';
import '../response/chat_response.dart';

extension ChatMapper on ChatResponse {
  ChatUidModel toDomain() => ChatUidModel(chatUid: chatUid);
}
