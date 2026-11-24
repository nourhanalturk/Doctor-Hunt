import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../request/send_message_request.dart';
import '../response/message_response.dart';

abstract class MessagesRemoteDataSource {
  Future<List<MessageResponse>> getMessages(String chatUid);

  Future<void> sendMessage(SendMessageRequest request);

  Stream<MessageResponse> listenToNewMessages(String chatUid);
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  static const String _messagesTable = 'messages';
  static const String _allChatsTable = 'all_chats';
  static const String _publicSchema = 'public';
  static const String _chatIdField = 'chat_id';
  static const String _createdAtField = 'created_at';
  static const String _contentField = 'content';
  static const String _senderIdField = 'sender_id';
  static const String _senderTypeField = 'sender_type';
  static const String _lastMessageField = 'last_message';

  final SupabaseClient client;

  StreamController<MessageResponse>? _messageStreamController;
  RealtimeChannel? _channel;

  MessagesRemoteDataSourceImpl(this.client);

  @override
  Future<List<MessageResponse>> getMessages(String chatUid) async {
    final currentUid = client.auth.currentUser?.id;
    final response = await client
        .from(_messagesTable)
        .select()
        .eq(_chatIdField, chatUid)
        .order(_createdAtField, ascending: true);

    return response
        .map((msg) => MessageResponse.fromJson(msg, currentUid!))
        .toList();
  }

  @override
  Future<void> sendMessage(SendMessageRequest request) async {
    final senderId = client.auth.currentUser!.id;

    await client.from(_messagesTable).insert({
      _chatIdField: request.chatUid,
      _senderIdField: senderId,
      _senderTypeField: request.senderType,
      _contentField: request.content,
      _createdAtField: request.createdAt,
    });

    await client
        .from(_allChatsTable)
        .update({
          _lastMessageField: request.content,
          SupabaseFieldsConstants.updatedAt: request.createdAt,
        })
        .eq(_chatIdField, request.chatUid);
  }

  @override
  Stream<MessageResponse> listenToNewMessages(String chatUid) {
    final currentUid = client.auth.currentUser?.id;

    final previousChannel = _channel;
    if (previousChannel != null) {
      client.removeChannel(previousChannel);
      _channel = null;
    }
    _messageStreamController?.close();

    final controller = StreamController<MessageResponse>.broadcast(
      onCancel: () {
        final channel = _channel;
        if (channel != null) {
          client.removeChannel(channel);
          _channel = null;
        }
      },
    );
    _messageStreamController = controller;

    final channel = client.channel('$_publicSchema:$_messagesTable');
    _channel = channel;
    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: _publicSchema,
      table: _messagesTable,
      filter: PostgresChangeFilter(
        column: _chatIdField,
        value: chatUid,
        type: PostgresChangeFilterType.eq,
      ),
      callback: (payload) {
        controller.add(
          MessageResponse.fromJson(payload.newRecord, currentUid!),
        );
      },
    );
    channel.subscribe();

    return controller.stream;
  }
}
