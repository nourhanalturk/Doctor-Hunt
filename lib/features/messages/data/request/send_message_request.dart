class SendMessageRequest {
  final String chatUid;
  final String content;
  final String senderType;
  final String createdAt;

  SendMessageRequest({
    required this.chatUid,
    required this.content,
    required this.senderType,
    required this.createdAt,
  });
}
