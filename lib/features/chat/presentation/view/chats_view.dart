import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/chat_room_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/modern_care_header.dart';
import 'package:tender/core/widgets/modern_empty_state.dart';
import 'package:tender/features/chat/presentation/controller/chats_controller.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async => controller.getChats(),
          child: AppScaffold(
            body: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                ModernCareHeader(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: ManagerStrings.myChats,
                  subtitle: ManagerStrings.chatWithYourDoctorsHere,
                  countLabel:
                      '${controller.combinedChats.length} ${ManagerStrings.chats}',
                ),
                const SizedBox(height: 26),
                if (controller.isLoading) ...List.generate(
                  4,
                  (_) => chatRoomShimmer(),
                ),
                if (!controller.isLoading && controller.combinedChats.isEmpty)
                  modernEmptyState(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: ManagerStrings.noChatsYet,
                    subtitle: ManagerStrings.chatWithYourDoctorsHere,
                    buttonText: ManagerStrings.findDoctors,
                    onPressed: () =>
                        Get.find<MainHomeController>().changeBottomNavIndex(0),
                  ),
                if (!controller.isLoading && controller.combinedChats.isNotEmpty)
                  ...controller.combinedChats.map(
                    (chat) => ChatRoomCard(
                      doctorName: chat.doctor.doctorName ?? '',
                      imageUrl: chat.doctor.image ?? '',
                      lastMessage: (chat.chat.lastMessage ?? '').trim().isEmpty
                          ? ManagerStrings.startConversation
                          : chat.chat.lastMessage!.trim(),
                      time: controller.formatChatTime(chat.chat.updatedAt),
                      onTap: () => controller.navigateToMessages(
                        chat.chat.chatId ?? '',
                        chat.doctor.doctorName ?? '',
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
