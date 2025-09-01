import 'package:get/get.dart';
import 'package:tender/features/chat/presentation/controller/chats_controller.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/messages/domain/di/di.dart';

import '../../../bookings/domain/di/di.dart';
import '../../../favorites/domain/di/di.dart';

initChats() {
  disposeHome();
  disposeBooking();
  disposeMessages();
  if (!Get.isRegistered<ChatsController>()) {
    Get.put<ChatsController>(ChatsController());
  }
}

disposeChats() {
  if (Get.isRegistered<ChatsController>()) {
    Get.delete<ChatsController>();
  }
}
