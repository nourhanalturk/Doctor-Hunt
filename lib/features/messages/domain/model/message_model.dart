class MessageModel {
  final String message;
  final bool isSender;

  MessageModel({required this.message, required this.isSender});

  factory MessageModel.fromJson(Map<String, dynamic> json, String currentUid) {
    return MessageModel(
      message: json['content'] ?? '',
      isSender: json['sender_id'] == currentUid,
    );
  }
}