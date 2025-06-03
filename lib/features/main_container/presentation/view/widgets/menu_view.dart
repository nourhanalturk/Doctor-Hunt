import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';
import 'package:tender/features/main_container/presentation/view/widgets/menu_item.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<MainContainerController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerHeight.h10,
            vertical: ManagerWidth.w20,
          ),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: ManagerRadius.r25,
                    ),
                    SizedBox(
                      width: ManagerWidth.w15,
                    ),
                    Column(
                      children: [
                        Text(
                          controller.name,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s18,
                            color: ManagerColors.white,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        controller.toggleMenu();
                      },
                      child: Container(
                        width: ManagerWidth.w50,
                        height: ManagerHeight.h30,
                        decoration: const BoxDecoration(
                          color: ManagerColors.redColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          ManagerIcons.clear,
                          color: ManagerColors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                Column(
                  children: List.generate(
                    controller.items.length,
                    (index) {
                      var model = controller.items[index];
                      return menuItem(
                          imagePath: model.imagePath,
                          title: model.title,
                          isSelected: index == controller.selectedTapIndex,
                          onTap: model.onTap,
                          //onTap: model.onTap,
                          );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
