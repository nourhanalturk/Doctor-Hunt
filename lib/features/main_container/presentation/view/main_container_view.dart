import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/features/main_container/presentation/view/widgets/menu_view.dart';
import '../../../home/presentation/view/home_view.dart';
import '../controller/main_container_controller.dart';

class MainContainerView extends StatelessWidget {
  const MainContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainContainerController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ManagerColors.white,
                      ManagerColors.lightBlueGray,
                      ManagerColors.midBlueGray,
                      ManagerColors.darkBlueGray,
                    ],
                    stops: [0.0, 0.0, 0.6, 1.0],
                  ),
                ),
              ),
              const MenuView(),
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  double slide = 270 * controller.animationController.value;
                  double scale =
                      1 - (controller.animationController.value * 0.2);

                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanUpdate: (details) {
                        final dx = details.delta.dx;
                        final dy = details.delta.dy;

                        if (dx > 0 && dx.abs() > dy.abs()) {
                          final isMenuOpen = controller.animationController.isCompleted;
                          if (!isMenuOpen) {
                            controller.changeBottomNavStatus(false);
                            controller.toggleMenu();
                          }
                        }

                        if (dx < 0 && dx.abs() > dy.abs()) {
                          final isMenuOpen = controller.animationController.isCompleted;
                          if (isMenuOpen) {
                            controller.changeBottomNavStatus(true);
                            controller.toggleMenu();
                          }
                        }
                      },
                      child: const HomeView(),
                    ),

                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
