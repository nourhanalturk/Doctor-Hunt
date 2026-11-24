import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/bookings/presentation/view/bookings_view.dart';
import 'package:tender/features/chat/presentation/view/chats_view.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';
import 'package:tender/features/main_container/presentation/view/main_container_view.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../favorites/presentation/view/favorites_view.dart';
import '../../domain/di/di.dart';
import '../../domain/model/auth_state_model.dart';
import '../../domain/usecase/check_internet_connection_usecase.dart';
import '../../domain/usecase/watch_auth_state_usecase.dart';

class MainHomeController extends GetxController {
  int currentBottomNavIndex = 0;

  StreamSubscription<AuthStateModel>? _authStateSubscription;

  final MainContainerController mainContainerController = Get.find();

  List<BottomNavigationBarItem> get items => [
        buildBottomNavItem(icon: ManagerImages.home, index: 0),
        buildBottomNavItem(icon: ManagerImages.favorite, index: 1),
        buildBottomNavItem(icon: ManagerImages.details, index: 2),
        buildBottomNavItem(icon: ManagerImages.chatting, index: 3),
      ];

  buildBottomNavItem({required String icon, required int index}) {
    final bool isSelected = index == currentBottomNavIndex;

    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? ManagerColors.primaryColor
              : ManagerColors.transparent,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          color: isSelected ? ManagerColors.white : ManagerColors.grey,
        ),
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
    const FavoritesView(),
    const BookingsView(),
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
