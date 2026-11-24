import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/features/messages/data/request/send_message_request.dart';
import 'package:tender/features/messages/domain/model/message_model.dart';
import 'package:tender/features/messages/domain/usecase/get_messages_usecase.dart';
import 'package:tender/features/messages/domain/usecase/listen_to_new_messages_usecase.dart';
import 'package:tender/features/messages/domain/usecase/send_message_usecase.dart';

class MessagesController extends GetxController {
  TextEditingController messageController = TextEditingController();
  late String chatUid;
  List<MessageModel> messages = [];

  StreamSubscription<MessageModel>? _newMessagesSubscription;
  bool _isClosed = false;

  fetchMessages() async {
    chatUid = CacheData.chatUid;
    GetMessagesUseCase useCase = instance<GetMessagesUseCase>();
    (await useCase.execute(chatUid)).fold(
      (l) {},
      (response) {
        if (_isClosed) return;
        messages = response;
        update();
      },
    );
  }

  sendMessage() async {
    print(chatUid);

    String messageText = messageController.text;
    if (messageText == null) return;

    SendMessageRequest request = SendMessageRequest(
      chatUid: chatUid,
      content: messageText,
      senderType: 'patient', //todo : handle isDoctor from the auth screens
      createdAt: DateTime.now().toIso8601String(),
    );

    SendMessageUseCase useCase = instance<SendMessageUseCase>();
    (await useCase.execute(request)).fold(
      (l) {},
      (r) {
        if (_isClosed) return;
        messageController.clear();
      },
    );
  }

  void listenToNewMessages() {
    ListenToNewMessagesUseCase useCase =
        instance<ListenToNewMessagesUseCase>();
    useCase.execute(chatUid).then(
      (result) {
        if (_isClosed) return;
        result.fold(
          (l) {},
          (stream) {
            _newMessagesSubscription?.cancel();
            _newMessagesSubscription = stream.listen((newMessage) {
              if (_isClosed) return;
              messages.add(newMessage);
              update();
            });
          },
        );
      },
    );
  }

  @override
  void onInit() {
    chatUid = CacheData.chatUid;

    fetchMessages();
    listenToNewMessages();
    super.onInit();
  }

  @override
  void onClose() {
    _isClosed = true;
    _newMessagesSubscription?.cancel();
    // Keep messageController alive: disposeMessages() runs from the view's
    // back button while the TextField is still mounted, and an in-flight
    // sendMessage()/realtime update can still reference it.
    super.onClose();
  }
}
