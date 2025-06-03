import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/widgets/chat_container.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/chat/presentation/controller/chats_controller.dart';
import 'package:tender/features/chat/presentation/view/widget/shimmer_chat_item.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_styles.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<ChatsController>(
      builder: (controller) {
        return AppScaffold(
          body: Column(
            children: [
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Container(
                height: size.height * ManagerOpacity.op0_15,
                width: size.width * ManagerOpacity.op0_9,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0EBE7F),
                        Color(0xFF0EC8A6),
                        ManagerColors.white.withOpacity(0.2),
                        Color(0xFF0EC8A6),
                        Color(0xFF0ED6C9),
                      ],
                      stops: [0.0, 0.4, 0.45, 0.6, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      transform: GradientRotation(pi / 6),
                    ),
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      )
                    ]),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Expanded(
                child: controller.isLoading
                    ? ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) => shimmerChatItem(),
                      )
                    : ListView.builder(
                        itemCount: controller.allChats.length,
                        itemBuilder: (context, index) {
                          var model = controller.data[index];
                          return chatsContainer(
                            imagePath: model.image.onNull(),
                            doctorName: model.doctorName.onNull(),
                            onTap: () {
                              controller.navigateToMessages(
                                controller.allChats[index].chatId.onNull(),
                                model.doctorName.onNull(),
                              );
                            },
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
