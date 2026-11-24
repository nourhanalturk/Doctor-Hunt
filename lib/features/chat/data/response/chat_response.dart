import '../../../../config/constants/supabase_fields_constants.dart';

class ChatResponse {
  final String? chatId;
  final int? doctorId;
  final String? patientId;
  final String? lastMessage;
  final String? updatedAt;

  ChatResponse({
    this.chatId,
    this.doctorId,
    this.patientId,
    this.lastMessage,
    this.updatedAt,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      chatId: json[SupabaseFieldsConstants.chatId],
      doctorId: json[SupabaseFieldsConstants.doctorId],
      patientId: json[SupabaseFieldsConstants.patientId],
      lastMessage: json[SupabaseFieldsConstants.lastMessage],
      updatedAt: json[SupabaseFieldsConstants.updatedAt],
    );
  }
}
