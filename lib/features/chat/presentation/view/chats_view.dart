import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_width.dart';
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
                  gradient: LinearGradient(colors: [
                    ManagerColors.white,
                    ManagerColors.primaryColor
                        .withOpacity(ManagerOpacity.op0_5),
                  ]),
                  borderRadius: BorderRadius.circular(
                    ManagerRadius.r12,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        ManagerImages.logo,
                      ),
                    ),
                    SizedBox(
                      width: ManagerWidth.w10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: ManagerHeight.h10,
                      ),
                      child: Text(
                        ManagerStrings.chats,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s30,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
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
                        itemCount: controller.combinedChats.length,
                        itemBuilder: (context, index) {
                          var model = controller.combinedChats[index].doctor;
                          return chatsContainer(
                            imagePath: model.image.onNull(),
                            doctorName: model.doctorName.onNull(),
                            onTap: () {
                              controller.navigateToMessages(
                                controller.combinedChats[index].chat.chatId.onNull(),
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
