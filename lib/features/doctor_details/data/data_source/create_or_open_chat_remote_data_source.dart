import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../response/chat_response.dart';

abstract class CreateOrOpenChatRemoteDataSource {
  Future<ChatResponse> createOrOpenChat(int doctorId);
}

class CreateOrOpenChatRemoteDataSourceImpl
    implements CreateOrOpenChatRemoteDataSource {
  static const String _allChatsTable = 'all_chats';
  static const String _lastMessageField = 'last_message';
  static const String _updatedAtField = 'updated_at';

  final SupabaseClient client;

  CreateOrOpenChatRemoteDataSourceImpl(this.client);

  @override
  Future<ChatResponse> createOrOpenChat(int doctorId) async {
    final patientUid = client.auth.currentUser!.id;

    final existingResponse = await client
        .from(_allChatsTable)
        .select()
        .eq(SupabaseFieldsConstants.doctorId, doctorId)
        .eq(SupabaseFieldsConstants.patientId, patientUid)
        .maybeSingle();

    if (existingResponse != null) {
      return ChatResponse.fromJson(existingResponse);
    }

    final newChatResponse = await client
        .from(_allChatsTable)
        .insert({
          SupabaseFieldsConstants.doctorId: doctorId,
          SupabaseFieldsConstants.patientId: patientUid,
          _lastMessageField: null,
          _updatedAtField: DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    return ChatResponse.fromJson(newChatResponse);
  }
}
