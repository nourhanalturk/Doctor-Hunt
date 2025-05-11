import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/features/chat/presentation/view/chat_view.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/home/presentation/view/home_view.dart';

import '../../../favorites/domain/di/di.dart';
import '../../../favorites/presentation/view/favorites_view.dart';

class MainHomeController extends GetxController {
  int currentBottomNavIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ManagerImages.home,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ManagerImages.favorite,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ManagerImages.details,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ManagerImages.chatting,
      ),
      label: '',
    ),
  ];

  changeBottomNavIndex(int index) {
    currentBottomNavIndex = index;
    initDI();
    update();
  }

  initDI() {
    switch (currentBottomNavIndex) {
      case 0:
        initHome();
      case 1:
        initFavorites();
      case 2:
        initHome();
      case 3:
        initHome();
    }
  }

  List<Widget> pages = [
    const HomeView(),
    const FavoritesView(),
    const HomeView(),
    const ChatView(),
  ];

  @override
  void onInit() {
    initDI();
    super.onInit();
  }
}
