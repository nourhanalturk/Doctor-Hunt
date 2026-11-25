import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/bookings/presentation/view/bookings_view.dart';
import 'package:tender/features/chat/presentation/view/chats_view.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';
import 'package:tender/features/main_container/presentation/view/main_container_view.dart';
import '../../../favorites/presentation/view/favorites_view.dart';
import '../../domain/di/di.dart';
import '../../domain/model/auth_state_model.dart';
import '../../domain/usecase/check_internet_connection_usecase.dart';
import '../../domain/usecase/watch_auth_state_usecase.dart';

const Color _navActiveColor = Color(0xFF168A57);
const Color _navInactiveColor = Color(0xFF7E8A86);

class MainHomeController extends GetxController {
  int currentBottomNavIndex = 0;

  StreamSubscription<AuthStateModel>? _authStateSubscription;

  final MainContainerController mainContainerController = Get.find();

  List<BottomNavigationBarItem> get items => [
        buildBottomNavItem(
          icon: Icons.home_rounded,
          label: 'Home',
          index: 0,
        ),
        buildBottomNavItem(
          icon: Icons.calendar_month_outlined,
          label: 'Appointments',
          index: 1,
        ),
        buildBottomNavItem(
          icon: Icons.favorite_border,
          label: 'Favorites',
          index: 2,
        ),
        buildBottomNavItem(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'Chats',
          index: 3,
        ),
      ];

  buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = index == currentBottomNavIndex;

    return BottomNavigationBarItem(
      label: label,
      icon: Icon(
        icon,
        size: 22,
        color: isSelected ? _navActiveColor : _navInactiveColor,
      ),
    );
  }

  changeBottomNavIndex(int index) {
    currentBottomNavIndex = index;
    initDI();
    update();
  }

  initDI() => initMainHomeTab(currentBottomNavIndex);

  List<Widget> pages = [
    const MainContainerView(),
    const BookingsView(),
    const FavoritesView(),
    const ChatsView(),
  ];

  void listenToAuthChanges() async {
    final result = await instance<WatchAuthStateUseCase>().execute();

    result.fold(
      (_) => null,
      (stream) {
        _authStateSubscription = stream.listen((state) {
          print('Auth event: ${state.event}');
          print('User id: ${state.userId}');

          if (!state.hasSession) {
            Get.toNamed(Routes.login);
          }
        });
      },
    );
  }

  checkInternetConnection() async {
    await instance<CheckInternetConnectionUseCase>().execute();
  }

  @override
  void onInit() {
    listenToAuthChanges();
    initDI();
    checkInternetConnection();
    super.onInit();
  }

  @override
  void onClose() {
    _authStateSubscription?.cancel();
    _authStateSubscription = null;
    super.onClose();
  }
}
