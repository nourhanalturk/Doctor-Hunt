import 'dart:async';

import 'package:flutter/material.dart';
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
  final ScrollController scrollController = ScrollController();
  late String chatUid;
  List<MessageModel> messages = [];

  StreamSubscription<MessageModel>? _newMessagesSubscription;
  bool _isClosed = false;

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isClosed || !scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  fetchMessages() async {
    chatUid = CacheData.chatUid;
    GetMessagesUseCase useCase = instance<GetMessagesUseCase>();
    (await useCase.execute(chatUid)).fold(
      (l) {},
      (response) {
        if (_isClosed) return;
        messages = response;
        update();
        _scrollToBottom();
      },
    );
  }

  sendMessage() async {
    if (_isClosed) return;

    final String messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

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
        _scrollToBottom();
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
              _scrollToBottom();
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
    // Keep messageController and scrollController alive: the back button calls
    // disposeMessages() while the view is still mounted, and in-flight sends or
    // realtime updates can still reference them during the pop animation.
    super.onClose();
  }
}
