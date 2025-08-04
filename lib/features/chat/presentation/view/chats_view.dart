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
import 'package:tender/core/widgets/empty_state.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/chat/presentation/controller/chats_controller.dart';
import 'package:tender/features/chat/presentation/view/widget/shimmer_chat_item.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_styles.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return GetBuilder<ChatsController>(
      builder: (controller) {
        return controller.allChats.isEmpty
            ?  EmptyStateWidget(
          appBarTitle: ManagerStrings.myChats,
          title: ManagerStrings.noChatsYet,
          subtitle: ManagerStrings.chatWithYourDoctorsHere ,
          buttonText: ManagerStrings.findDoctors,
          onPressed: () {
          },
          svgAssetPath: ManagerImages.imageIcon,
        )
            : AppScaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.06),

                      Row(
                        children: [
                          SvgPicture.asset(
                            ManagerImages.logo,
                            height: height * 0.05,
                          ),
                          SizedBox(width: width * 0.03),
                          Text(
                            ManagerStrings.chatWithYourDoctorsHere,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s25,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.03),

                      /// Chat List
                      Expanded(
                        child: controller.isLoading
                            ? ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) =>
                                    shimmerChatItem(),
                              )
                            : ListView.separated(
                                itemCount: controller.combinedChats.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: height * 0.015),
                                itemBuilder: (context, index) {
                                  final chat = controller.combinedChats[index];
                                  final doctor = chat.doctor;
                                  final lastMsg =
                                      chat.chat.lastMessage ?? "مرحبا 👋";

                                  return InkWell(
                                    onTap: () {
                                      controller.navigateToMessages(
                                        chat.chat.chatId.onNull(),
                                        doctor.doctorName.onNull(),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.015,
                                        horizontal: width * 0.04,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ManagerColors.white,
                                        borderRadius: BorderRadius.circular(
                                            ManagerRadius.r12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          /// Profile Image
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              doctor.image.onNull(),
                                              height: height * 0.07,
                                              width: height * 0.07,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Icon(Icons.person,
                                                      size: height * 0.07,
                                                      color:
                                                          ManagerColors.grey),
                                            ),
                                          ),
                                          SizedBox(width: width * 0.04),

                                          /// Name + Last Message
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doctor.doctorName.onNull(),
                                                  style: getMediumTextStyle(
                                                    fontSize:
                                                        ManagerFontSize.s18,
                                                    color: ManagerColors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height * 0.005),
                                                Text(
                                                  lastMsg.length > 40
                                                      ? '${lastMsg.substring(0, 40)}...'
                                                      : lastMsg,
                                                  style: getRegularTextStyle(
                                                    fontSize:
                                                        ManagerFontSize.s14,
                                                    color: ManagerColors.grey,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),

                                          /// Time
                                          // Text(
                                          //   chat.chat.doctorId ?? "الآن",
                                          //   style: getRegularTextStyle(
                                          //     fontSize: ManagerFontSize.s12,
                                          //     color: ManagerColors.grey,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
