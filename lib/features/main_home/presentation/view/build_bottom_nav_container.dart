import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_fonts.dart';

import '../controller/main_home_controller.dart';

Widget buildBottomNavContainer(MainHomeController controller, Size size) {
  final double bottomInset = MediaQuery.of(Get.context!).padding.bottom;
  final List<BottomNavigationBarItem> items = controller.items;

  return Container(
    height: 76 + bottomInset,
    padding: EdgeInsets.only(bottom: bottomInset),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0x0D000000),
          blurRadius: 24,
          offset: Offset(0, -6),
        ),
      ],
    ),
    child: Row(
      children: List<Widget>.generate(items.length, (index) {
        final bool isActive = index == controller.currentBottomNavIndex;
        final BottomNavigationBarItem item = items[index];

        return Expanded(
          child: InkWell(
            onTap: () => controller.changeBottomNavIndex(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.icon,
                const SizedBox(height: 4),
                Text(
                  item.label ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 11.5,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? const Color(0xFF168A57)
                        : const Color(0xFF7E8A86),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  width: 18,
                  height: 3,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF168A57)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}
