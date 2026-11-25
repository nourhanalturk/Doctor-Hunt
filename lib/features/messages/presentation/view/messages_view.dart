import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/chat_background.dart';
import 'package:tender/core/widgets/glass_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/modern_message_bubble.dart';
import 'package:tender/features/messages/domain/di/di.dart';
import 'package:tender/features/messages/presentation/controller/messages_controller.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessagesController>(
      builder: (controller) {
        return AppScaffold(
          body: Stack(
            children: [
              const ChatBackground(),
              Column(
                children: [
                  _buildHeader(controller),
                  Expanded(
                    child: controller.messages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  size: 42,
                                  color: Color(0xFF168A57),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  ManagerStrings.startConversation,
                                  style: TextStyle(
                                    fontFamily: ManagerFontFamily.fontFamily,
                                    fontSize: 14,
                                    color: const Color(0xFF6E7B76),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            controller: controller.scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              final model = controller.messages[index];
                              return modernMessageBubble(
                                isSender: model.isSender,
                                message: model.message,
                              );
                            },
                          ),
                  ),
                  _buildComposer(controller),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(MessagesController controller) {
    return Container(
      height: 116,
      padding: const EdgeInsetsDirectional.only(start: 16, end: 16, top: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
          colors: [Color(0xFF9CE0C0), Color(0xFFE6F7EE)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x12154734),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              disposeMessages();
              Get.back();
            },
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x99FFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F154734),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF154734),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  CacheData.doctorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF154734),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2ECC7E),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      ManagerStrings.online,
                      style: TextStyle(
                        fontFamily: ManagerFontFamily.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF227350),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer(MessagesController controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        bottom: 16,
        top: 6,
      ),
      child: GlassCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        borderRadius: 999,
        blur: 10,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.messageController,
                onSubmitted: (_) => controller.sendMessage(),
                style: TextStyle(
                  fontFamily: ManagerFontFamily.fontFamily,
                  fontSize: 14.5,
                  color: const Color(0xFF1E2422),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: ManagerStrings.typeYourMessage,
                  hintStyle: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 14,
                    color: const Color(0xFF7E8A86),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: controller.sendMessage,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF168A57), Color(0xFF32A577)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33168A57),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  size: 19,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
