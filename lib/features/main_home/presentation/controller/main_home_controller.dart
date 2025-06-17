import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/bookings/domain/di/di.dart';
import 'package:tender/features/bookings/presentation/view/bookings_view.dart';
import 'package:tender/features/chat/domain/di/di.dart';
import 'package:tender/features/chat/presentation/view/chats_view.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/home/presentation/view/home_view.dart';
import 'package:tender/features/main_container/domain/di/di.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';
import 'package:tender/features/main_container/presentation/view/main_container_view.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../favorites/domain/di/di.dart';
import '../../../favorites/presentation/view/favorites_view.dart';

class MainHomeController extends GetxController {
  int currentBottomNavIndex = 0;

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

  initDI() {
    switch (currentBottomNavIndex) {
      case 0:
        {
          initHome();

        }
      case 1:
        initFavorites();
      case 2:
        initBookings();
      case 3:
        initChats();
    }
  }

  List<Widget> pages = [
    const MainContainerView(),
    const FavoritesView(),
    const BookingsView(),
    const ChatsView(),
  ];

  void listenToAuthChanges() {
    final supabase = Supabase.instance.client;

    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      print('Auth event: $event');
      print('User id: ${session?.user?.id}');

      if (session == null) {
        Get.toNamed(Routes.login);
      }
    });
  }
  checkInternetConnection()async{
    NetworkInfo networkInfo = instance<NetworkInfo>();
    if(!await networkInfo.isConnected){

    }
  }
  @override
  void onInit() {
    listenToAuthChanges();
    initDI();
    checkInternetConnection();
    super.onInit();
  }
}
