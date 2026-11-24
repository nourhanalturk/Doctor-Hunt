class MessageResponse {
  final String message;
  final bool isSender;

  MessageResponse({required this.message, required this.isSender});

  factory MessageResponse.fromJson(
    Map<String, dynamic> json,
    String currentUid,
  ) {
    return MessageResponse(
      message: json['content'] ?? '',
      isSender: json['sender_id'] == currentUid,
    );
  }
}
