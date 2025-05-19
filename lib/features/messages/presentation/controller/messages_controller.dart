import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/features/messages/domain/model/message_model.dart';

class MessagesController extends GetxController {
  TextEditingController messageController = TextEditingController();
  late String chatUid;
  List<MessageModel> messages = [];

  fetchMessages() async {
    final currentUid = supabase.auth.currentUser?.id;

    final response = await supabase
        .from('messages')
        .select()
        .eq('chat_id', chatUid)
        .order('created_at', ascending: true);

    messages = response
        .map<MessageModel>((msg) => MessageModel.fromJson(msg, currentUid!))
        .toList();

    print(messages);
    update();
  }

  sendMessage() async {
    print(chatUid);

    String messageText = messageController.text;
    if (messageText == null) return;

    final senderId = supabase.auth.currentUser!.id;
    final senderType = 'patient'; //todo : handle isDoctor from the auth screens
    final timestamp = DateTime.now().toIso8601String();

    await supabase.from('messages').insert({
      'chat_id': chatUid,
      'sender_id': senderId,
      'sender_type': senderType,
      'content': messageText,
      'created_at': timestamp,
    });

    await supabase.from('all_chats').update({
      'last_message': messageText,
      'updated_at': timestamp,
    }).eq('chat_id', chatUid);

    messageController.clear();
  }

  void listenToNewMessages() {
    final currentUid = supabase.auth.currentUser?.id;

    final channel = supabase.channel('public:messages');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        column: 'chat_id',
        value: chatUid,
        type: PostgresChangeFilterType.eq,
      ),
      callback: (payload) {
        final newData = payload.newRecord;
        if (newData == null) return;

        final newMessage = MessageModel.fromJson(newData, currentUid!);
        messages.add(newMessage);
        update();
      },
    );

    channel.subscribe();
  }

  @override
  void onInit() {
    chatUid = CacheData.chatUid;
    fetchMessages();
    listenToNewMessages();
    super.onInit();
  }
}
