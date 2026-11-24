import '../../../../config/constants/supabase_fields_constants.dart';

class ChatResponse {
  final String chatUid;

  ChatResponse({required this.chatUid});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      chatUid: json[SupabaseFieldsConstants.chatId] as String? ?? '',
    );
  }
}
