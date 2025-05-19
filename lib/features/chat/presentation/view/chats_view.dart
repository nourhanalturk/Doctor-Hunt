import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tender/core/widgets/chat_container.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/chat/presentation/controller/chats_controller.dart';
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
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: ManagerColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
        );
        return AppScaffold(
          body: Column(
            children: [
              Container(
                height: size.height * ManagerOpacity.op0_09,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      ManagerRadius.r25,
                    ),
                    bottomRight: Radius.circular(
                      ManagerRadius.r25,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + ManagerHeight.h30,
                    left: ManagerHeight.h30,
                    right: ManagerHeight.h30,
                  ),
                  child: Text(
                    ManagerStrings.chats,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s25,
                      color: ManagerColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_05,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return chatsContainer(imagePath: '', doctorName: "Nourhan Turk ",onTap: () {

                    },);
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
